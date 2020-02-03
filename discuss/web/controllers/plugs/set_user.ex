defmodule Discuss.Plugs.SetUser do
  import Plug.Conn
  import Phoenix.Controller


  def init(_params) do
    
  end

  def call(conn, _params) do
    #get_session coming from controller
    user_id = get_session(conn, :user_id)
    IO.inspect(user_id)
    cond do
      #assign comming from Plug.Conn
      user = user_id && Discuss.Repo.get(Discuss.User, user_id) -> 
        assign(conn, :user, user)
      true -> 
        assign(conn, :user, nil)
    end

  end

end
