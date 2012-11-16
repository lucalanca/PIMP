class PunchesController < ApplicationController

  # GET /punches
  # GET /punches.json
  def index
    @punches = Punch.all
    @query   = params[:search]

    if @query
      @query.downcase!
      punches_a = Punch.arel_table
      @punches = Punch.where(punches_a[:alias].matches("%#{@query}%").or(punches_a[:mac].matches("%#{@query}%")))
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @punches }
    end
  end

  # GET /punches/1
  # GET /punches/1.json
  def show
    @punch = Punch.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @punch }
    end
  end

  # GET /punches/new
  # GET /punches/new.json
  def new
    @alias     = params[:alias] || ""
    @mac       = params[:mac]
    @local_ip  = params[:local_ip]
    @public_ip = params[:public_ip]

    if !@alias || !@mac || !@local_ip || !@public_ip
      @punch = Punch.new
      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @punch }
      end
      return
    else
      logger.debug "find by mac"
      prev_punch = Punch.find_by_mac(@mac)
      if prev_punch
        prev_punch.update_attributes alias: @alias, local_ip: @local_ip, public_ip: @public_ip, mac: prev_punch.mac
        logger.debug "updated"
      else
        logger.debug "mac not found. will create"
        @punch = Punch.create alias: @alias, mac: @mac.downcase, local_ip: @local_ip, public_ip: @public_ip
        logger.debug "created"
      end
    end

    logger.debug "redirecting to root"
    redirect_to :root
  end

  # GET /punches/1/edit
  def edit
    @punch = Punch.find(params[:id])
  end

  # POST /punches
  # POST /punches.json
  def create
    @punch = Punch.new(params[:punch])

    respond_to do |format|
      if @punch.save
        format.html { redirect_to @punch, notice: 'Punch was successfully created.' }
        format.json { render json: @punch, status: :created, location: @punch }
      else
        format.html { render action: "new" }
        format.json { render json: @punch.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /punches/1
  # PUT /punches/1.json
  def update
    @punch = Punch.find(params[:id])

    respond_to do |format|
      if @punch.update_attributes(params[:punch])
        format.html { redirect_to @punch, notice: 'Punch was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @punch.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /punches/1
  # DELETE /punches/1.json
  def destroy
    @punch = Punch.find(params[:id])
    @punch.destroy

    respond_to do |format|
      format.html { redirect_to punches_url }
      format.json { head :no_content }
    end
  end
end
