%% @author author <author@example.com>
%% @copyright YYYY author.
%% @doc Example webmachine_resource.

-module(webmachine_geojson_resource).
-export([init/1,
         allowed_methods/2,
         content_types_provided/2,
         to_json/2,
         process_post/2]).

-include_lib("webmachine/include/webmachine.hrl").

init([]) -> {ok, undefined}.

allowed_methods(RD, Ctx) ->
    {['GET', 'HEAD', 'POST'], RD, Ctx}.
 
content_types_provided(RD, Ctx) ->
    {[{"application/json", to_json}], RD, Ctx}.


%% to_html(ReqData, State) ->
%%    {"<html><body>This is gonna be fun!</body></html>", ReqData, State}.

%%   curl "http://localhost:8000/?1st=Hello&2nd=There!"
to_json(RD, Ctx) ->
    {json_body(wrq:req_qs(RD)), RD, Ctx}.

%%   curl -X POST http://localhost:8000/formjson \
%%        -d "1st=Hello!&2nd=There!"
process_post(RD, Ctx) ->
    Body = json_body(mochiweb_util:parse_qs(wrq:req_body(RD))),
    {true, wrq:append_to_response_body(Body, RD), Ctx}.
 
json_body(QS) -> mochijson:encode({struct, QS}).