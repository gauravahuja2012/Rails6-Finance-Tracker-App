class Stock < ApplicationRecord
  has_many :user_stocks
  has_many :users, through: :user_stocks

  validates :name, :ticker, presence: true

  def self.new_lookup(ticker_symbol)
    # client = IEX::Api::Client.new(publishable_token: Rails.application.credentials.iex_client[:sandbox_api_key], endpoint: 'https://sandbox.iexapis.com/v1')

    client = [{ticker: "AMZN", name: "Amazom Inc.", price: "1100.45"}, {ticker: "GOOL", name: "Google Inc.", price: "1300.12"}, 
              {ticker: "MSFT", name: "Microsoft Inc.", price: "1200"}, {ticker: "FB", name: "Facebook Inc.", price: "900.55"},
              {ticker: "TEST", name: "Test Inc.", price: "100.01"}, {ticker: "ABC", name: "ABC Inc.", price: "90.55"}]
    # Search for a value in the hash array
    begin
      result = client.find { |p| p[:ticker] == ticker_symbol }
      new(ticker: ticker_symbol, name: result[:name], last_price: result[:price])
    rescue => exception
      return nil
    end
  end

  def self.check_db(ticker_symbol)
    where(ticker: ticker_symbol).first
  end
  
end
