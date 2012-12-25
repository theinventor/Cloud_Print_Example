require 'net/http'

class PrintersController < ApplicationController
  # GET /printers
  # GET /printers.json
  def index
    return redirect_to "/auth/google_oauth2" unless session[:refresh_token]
    hash = {
      :refresh_token => session[:refresh_token],
      :client_id => "893110491171.apps.googleusercontent.com",
      :client_secret => "hBaYoCclmKH7IUgDYYdk4H0v",
      :callback_url => "http://localhost:3000/auth/google_oauth2/callback"
    }

    @setup = CloudPrint.setup(hash)
    @printers = CloudPrint::Printer.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @printers }
    end
  end

  def refresh
    #TODO go get all the google printers and create records for them in the database!

  end

  # GET /printers/1
  # GET /printers/1.json
  def show
    @printer = Printer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @printer }
    end
  end

  def queue_test
    @printer = CloudPrint::Printer.find(params[:id])
    if @printer.print(:content => "www.tobcon.ie/assets/files/test.pdf", :title => "This is a test", :content_type => "pdf")
      flash[:success] = "Print Job Queued"
      redirect_to printers_path
    end
  end

  # GET /printers/new
  # GET /printers/new.json
  def new
    @printer = Printer.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @printer }
    end
  end

  # GET /printers/1/edit
  def edit
    @printer = Printer.find(params[:id])
  end

  # POST /printers
  # POST /printers.json
  def create
    @printer = Printer.new(params[:printer])

    respond_to do |format|
      if @printer.save
        format.html { redirect_to @printer, notice: 'Printer was successfully created.' }
        format.json { render json: @printer, status: :created, location: @printer }
      else
        format.html { render action: "new" }
        format.json { render json: @printer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /printers/1
  # PUT /printers/1.json
  def update
    @printer = Printer.find(params[:id])

    respond_to do |format|
      if @printer.update_attributes(params[:printer])
        format.html { redirect_to @printer, notice: 'Printer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @printer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /printers/1
  # DELETE /printers/1.json
  def destroy
    @printer = Printer.find(params[:id])
    @printer.destroy

    respond_to do |format|
      format.html { redirect_to printers_url }
      format.json { head :no_content }
    end
  end
end
