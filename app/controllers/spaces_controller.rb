class SpacesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_space, only: [:show, :edit, :update, :destroy]

  # GET /spaces
  # GET /spaces.json
  def index
    @spaces = Space.all
    # redirect_to "/map"
  end

  # GET /spaces/1
  # GET /spaces/1.json
  def show
    @hant = current_user.hants.build
    @hants = Hant.where(space_id: @space.id).order(created_at: :desc)
    @hash = Gmaps4rails.build_markers(@space) do |space, marker|
      marker.lat space.latitude
      marker.lng space.longitude
      marker.json({title: space.title})
    end
  end

  def list
    keyword = params[:search]
    @client = GooglePlaces::Client.new( ENV['GOOGLE_API_KEY'] )
    @spaces = @client.spots_by_query( keyword )
  end

  # GET /spaces/new
  def new
    @spaces = Space.all
    @hash = Gmaps4rails.build_markers(@spaces) do |space, marker|
      marker.lat space.latitude
      marker.lng space.longitude
      marker.infowindow get_marker_info(space)
      marker.json({title: space.title})
    end
    @space = current_user.spaces.build
  end

  # GET /spaces/1/edit
  def edit
  end

  # POST /spaces
  # POST /spaces.json
  def create
    @space = current_user.spaces.build(space_params)
    respond_to do |format|
      if @space.save
        format.html { redirect_to @space, flash:{success: 'スペースが作成されました'} }
        format.json { render :show, status: :created, location: @space }
      else
        @spaces = Space.all
        @hash = Gmaps4rails.build_markers(@spaces) do |space, marker|
          marker.lat space.latitude
          marker.lng space.longitude
          marker.infowindow get_marker_info(space)
          marker.json({title: space.title})
        end
        format.html { render :new }
        format.json { render json: @space.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /spaces/1
  # PATCH/PUT /spaces/1.json
  def update
    respond_to do |format|
      if @space.update(space_params)
        format.html { redirect_to @space, flash:{success: 'スペースが更新されました'} }
        format.json { render :show, status: :ok, location: @space }
      else
        format.html { render :edit }
        format.json { render json: @space.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /spaces/1
  # DELETE /spaces/1.json
  def destroy
    @space.destroy
    respond_to do |format|
      format.html { redirect_to spaces_url, flash:{success: 'スペースが削除されました'} }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_space
      @space = Space.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def space_params
      params.require(:space).permit(:title, :description, :address, :latitude, :longitude, :category)
    end

    def get_marker_info(space)
      category = t(".#{space.category}")
      case space.category
      when "cafe"
        gliyphicon = "glyphicon-glass"
      when "library"
        gliyphicon = "glyphicon-book"
      else
        gliyphicon = "glyphicon-globe"
      end
      return "<span class='glyphicon #{gliyphicon}' aria-hidden='true'></span> #{category}<br>
              #{space.title}<br>
              <a class='btn btn-success btn-xs' href='/spaces/#{space.id}'>スペースの詳細を見る</a>"
    end
end
