class HomeController < ApplicationController
  # Главная страница
  def index
  end
  
  def main
  end
  
  # Универсальный метод для всех статических страниц
  def show
    render template: "home/#{params[:page]}"
  end
end
