%% @author author <author@example.com>
%% @copyright YYYY author.

%% @doc webmachine_geojson startup code

-module(webmachine_geojson).
-author('author <author@example.com>').
-export([start/0, start_link/0, stop/0]).

ensure_started(App) ->
    case application:start(App) of
        ok ->
            ok;
        {error, {already_started, App}} ->
            ok
    end.

%% @spec start_link() -> {ok,Pid::pid()}
%% @doc Starts the app for inclusion in a supervisor tree
start_link() ->
    ensure_started(inets),
    ensure_started(crypto),
    ensure_started(mochiweb),
    application:set_env(webmachine, webmachine_logger_module, 
                        webmachine_logger),
    ensure_started(webmachine),
    webmachine_geojson_sup:start_link().

%% @spec start() -> ok
%% @doc Start the webmachine_geojson server.
start() ->
    ensure_started(inets),
    ensure_started(crypto),
    ensure_started(mochiweb),
    application:set_env(webmachine, webmachine_logger_module, 
                        webmachine_logger),
    ensure_started(webmachine),
    application:start(webmachine_geojson).

%% @spec stop() -> ok
%% @doc Stop the webmachine_geojson server.
stop() ->
    Res = application:stop(webmachine_geojson),
    application:stop(webmachine),
    application:stop(mochiweb),
    application:stop(crypto),
    application:stop(inets),
    Res.
