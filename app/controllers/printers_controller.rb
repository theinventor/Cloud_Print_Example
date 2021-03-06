class PrintersController < ApplicationController

  before_filter :authenticate_user!

  # GET /printers
  # GET /printers.json
  def index
    # @setup = CloudPrint.setup(hash)
    # @printers = CloudPrint::Printer.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @printers }
    end
  end

  def refresh
    @user_accounts = if params[:user_account]
                       [ UserAccount.find(params[:user_account]) ]
                     else
                        current_user.user_accounts
                     end
    
    @user_accounts.each do |user_account|
      hash = {
        :refresh_token => user_account.refresh_token,
        :client_id => "893110491171.apps.googleusercontent.com",
        :client_secret => "hBaYoCclmKH7IUgDYYdk4H0v",
        :callback_url => "http://localhost:3000/auth/google_oauth2/callback"
      }

      @setup = CloudPrint.setup(hash)
      CloudPrint.refresh_token = user_account.refresh_token
      @printers = CloudPrint::Printer.all
      @printers.each do |cloud_printer|
        user_account.create_unique_printer(cloud_printer)
      end
      #binding.pry
    end
    redirect_to printers_path
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
    #binding.pry
    if @printer.print(:content => File.open("#{Rails.root}/public/example-address-label.pdf"), :title => "example-address-label.pdf", :content_type => "application/pdf")
      flash[:success] = "Print Job Queued"
    else
      flash[:error] = "Please try again later"
    end
    redirect_to printers_path
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
