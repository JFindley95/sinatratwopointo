require 'sinatra'
require 'sinatra/activerecord'
require './models/rota.rb'
require 'pry'


class MyApp < Sinatra::Base

  get '/' do
    @uk_team_rota = Rota.where.not(uk_team_name:nil)
    @first_uk_team = Rota.order(:date).first.uk_team_name
    @us_team_rota = Rota.where.not(us_team_name:nil)# wont select nil values
    # @us_team_rota = Rota.select(:us_team_name, :date).reject{|h| h[:us_team_name].nil?}
    @first_us_team = Rota.order(:date).first.us_team_name
    # binding.pry
    erb :home
  end

  get '/new_uk' do
    erb :new_uk
  end

  post '/post_team_uk' do
  	@add_team_to_uk_rota = Rota.create(uk_team_name: params[:teamname], date: params[:date])
  	redirect '/'
  end

  get '/new_us' do
    erb :new_us
  end

  post '/post_team_us' do
  	@add_team_to_us_rota = Rota.create(us_team_name: params[:teamname], date: params[:date])
  	redirect '/'
  end

  get '/swap_uk' do
    erb :swap_uk
  end

  patch '/post_swap_uk' do
    @current_team = Rota.find_by(date: params[:currentdate])
    @current_team.update(uk_team_name: params[:swapteamname])
    @team_to_swap = Rota.find_by(date: params[:swapdate])
    @team_to_swap.update(uk_team_name: params[:currentteamname])
  	redirect '/'
  end

  delete '/:id' do
    @entry = Rota.find_by(id:params[:id]).destroy
    redirect '/'
  end
end
