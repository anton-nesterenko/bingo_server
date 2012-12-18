-module(bs_room_sup).

-behaviour(supervisor).

-export([start_link/0,
         start_child/0
        ]).

-export([init/1]).

-define(SERVER, ?MODULE).

start_link() ->
    supervisor:start_link({local, ?SERVER}, ?MODULE, []).

start_child() ->
    supervisor:start_child(?SERVER, []).

init([]) ->
    Room = {bs_room, {bs_room, start_link, []},
               temporary, brutal_kill, worker, [bs_room]},
    Children = [Room],
    RestartStrategy = {simple_one_for_one, 0, 1},
    {ok, {RestartStrategy, Children}}.