'use strict';

exports.handler = (event, context, callback) => {
    /*
     * Expand S3 request to have index.html if it ends in /
     */
    const request = event.Records[0].cf.request;
    if ((request.uri !== "/") /* Not the root object, which redirects properly */
        && (request.uri.endsWith("/") /* Folder with slash */
            || (request.uri.lastIndexOf(".") < request.uri.lastIndexOf("/")) /* Most likely a folder, it has no extension (heuristic) */
            )) {
        if (request.uri.endsWith("/"))
            request.uri = request.uri.concat("index.html");
        else
            request.uri = request.uri.concat("/index.html");
    }
    callback(null, request);
};

