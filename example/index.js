module.exports = async function (context, req) {
    context.log('JavaScript HTTP trigger function processed a request.');

    const authHeader = req.headers['authorization'] || req.headers['Authorization'];
    if (!authHeader || !authHeader.startsWith('Basic ')) {
        context.res = { status: 401, headers: { 'WWW-Authenticate': 'Basic' }, body: 'Unauthorized' };
        return;
    }

    const decoded = Buffer.from(authHeader.split(' ')[1], 'base64').toString('utf8');
    const [user, pass] = decoded.split(':');

    const expectedUser = process.env.BASIC_AUTH_USERNAME || 'user';
    const expectedPass = process.env.BASIC_AUTH_PASSWORD || 'password';

    if (user !== expectedUser || pass !== expectedPass) {
        context.res = { status: 403, body: 'Forbidden' };
        return;
    }

    const name = (req.query.name || (req.body && req.body.name));
    const responseMessage = name
        ? { id: name }
        : "This HTTP triggered function executed successfully. Pass a name in the query string or in the request body for a personalized response.";

    context.res = {
        body: responseMessage
    };
}