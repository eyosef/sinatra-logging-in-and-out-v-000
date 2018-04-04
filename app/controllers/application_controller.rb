require 'pry'
require_relative '../../config/environment'
class ApplicationController < Sinatra::Base
  configure do
    set :views, Proc.new { File.join(root, "../views/") }
    enable :sessions unless test?
    set :session_secret, "secret"
  end

  get '/' do
    erb :index
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user == nil
      erb :error
    else
      @user.password == params[:password]
      session[:user_id] = @user.id
      redirect to '/account'
    end
  end

  get '/account' do
    @user = User.find_by_id(session[:user_id])
    if @user == nil
      erb :error
    else
      erb :account
    end
  end

  get '/logout' do
    session.clear

    redirect to '/'

    #<User:0x000000040fa6c8
    # id: 1,
    # username: "skittles123",
    # password: "iluvskittles",
    # balance: 1000>
  end


end
