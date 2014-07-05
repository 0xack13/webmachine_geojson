%% @author author <author@example.com>
%% @copyright YYYY author.

%% @doc Callbacks for the webmachine_geojson application.

-module(webmachine_geojson_app).
-author('author <author@example.com>').

-behaviour(application).
-export([start/2,stop/1]).


%% @spec start(_Type, _StartArgs) -> ServerRet
%% @doc application start callback for webmachine_geojson.
start(_Type, _StartArgs) ->
    webmachine_geojson_sup:start_link().

%% @spec stop(_State) -> ServerRet
%% @doc application stop callback for webmachine_geojson.
stop(_State) ->
    ok.
