require "open-uri"
require "base64"

class BeveragesController < ApplicationController
  before_action :set_beverage, only: %i[ show edit update destroy ]
  protect_from_forgery unless: -> { request.format.json? }

  # GET /beverages or /beverages.json
  def index
    @beverages = Beverage.all.to_a
    respond_to do |format|
      format.html { STDERR.puts "INDEX...."; render :index }
      format.json { STDERR.puts "JSON...."; render json: @beverages }
    end
  end

  # GET /beverages/1 or /beverages/1.json
  def show
  end

  # GET /beverages/new
  def new
    @beverage = Beverage.new
  end

  # GET /beverages/1/edit
  def edit
  end

  # POST /beverages or /beverages.json
  def create
    @beverage = Beverage.new(beverage_params)
    data = snarf_image_data

    respond_to do |format|
      if @beverage.save
        if data
          STDERR.puts "UPDATING DATA"
          @beverage.image_data = Base64.encode64(data)
          @beverage.save
        end
        if mid = motor_id_param
          new_motor = Motor.find(mid)
          pp new_motor.id
          pp new_motor.uuid
          @beverage.motor = new_motor if new_motor
          @beverage.save
        end
        format.html { redirect_to @beverage, notice: "Beverage was successfully created." }
        format.json { render :show, status: :created, location: @beverage }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @beverage.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /beverages/1 or /beverages/1.json
  def update
    respond_to do |format|
      data = snarf_image_data
      if @beverage.update(beverage_params)
        if data
          STDERR.puts "UPDATING DATA"
          @beverage.image_data = Base64.encode64(data)
          @beverage.save
        end
        if mid = motor_id_param
          new_motor = Motor.find(mid)
          pp new_motor.id
          pp new_motor.uuid
          @beverage.motor = new_motor if new_motor
          @beverage.save
        end

        format.html { redirect_to @beverage, notice: "Beverage was successfully updated." }
        format.json { render :show, status: :ok, location: @beverage }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @beverage.errors, status: :unprocessable_entity }
      end
    end
  end

  def snarf_image_data
    data = nil
    STDERR.puts "snarfing us up some image data from #{beverage_params.inspect}"
    begin
      data = nil
      URI.open(beverage_params[:image_url]) do |f|
        data = f.read
      end
    rescue Exception => e
      STDERR.puts e
      # The right thing to do here would be to report an error.
      # So maybe do that?
    end
    
    data
  end

  # DELETE /beverages/1 or /beverages/1.json
  def destroy
    @beverage.destroy
    respond_to do |format|
      format.html { redirect_to beverages_url, notice: "Beverage was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # POST /beverages/dispense
  #   ids: list of IDs.
  def dispense
    STDERR.puts "dispensing for #{params[:ids]}"
    
    CurrentDrink[:beverage_ids] = params[:ids]
    CurrentDrink[:token] = Random.uuid
    amounts_dispensed = []

    STDERR.puts params.inspect
    params[:ids].each do |id|
      beverage = Beverage.find_by(identifier: id)
      if beverage
        STDERR.puts beverage.inspect
        STDERR.puts "sending D,#{beverage.amount} to #{motor.uuid}"

        Publisher.publish({
          "name" => motor.uuid,
          "command" => "D,#{beverage.amount}"
        }.to_json)

        amounts_dispensed << {motor: motor, amount: beverage.amount}
        # This is substandard. It is just waiting until it gets any message back from the bot
        # in response to a check on the amount dispensed. At the same time, the time to dispense 10-30ml
        # should be about 1 to 2.5 seconds, so do we really need to be paranoid beyond the time
        # it takes to confirm that _something_ has happened with each motor involved?
        # Probably, yes, but it is also 5:00 am, so live by the MVP, die by the MVP.
        # TODO: Make this smarter and less bad later.
        while amounts_dispensed.any?
          Publisher.publish({
            "name" => amounts_dispensed.last[:motor].uuid,
            "command" => "R"
          })
          while !(response = DrinkbotMessages.pop)
            sleep 0.1
          end
          STDERR.puts "DEBUG: Got #{response.inspect}"
          amounts_dispensed.pop
        end
      end
    end
    
    render json: {"status" => "SUCCESS"}
  end

  def status
    # Leaving this unimplemented for now. I don't think that we actually need it currently?
    render json: {"status" => "SUCCESS"}
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_beverage
      @beverage = Beverage.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def beverage_params
      params.require(:beverage).permit(:name, :identifier, :amount, :image_url, :image_data)
    end

    def motor_id_param
      params.require(:beverage).permit(:motor_id)["motor_id"]
    end
end
