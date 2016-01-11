class SpacesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_space, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_space_user!, only: [:edit, :update, :destroy]

  # GET /spaces
  # GET /spaces.json
  def index
    redirect_to controller: 'spaces', action: 'new'
  end

  # GET /spaces/1
  # GET /spaces/1.json
  def show
    @hant = current_user.hants.build
    @hants = Hant.where(space_id: @space.id).order(created_at: :desc)
    @hash = Gmaps4rails.build_markers(@space) do |space, marker|
      marker.lat space.latitude
      marker.lng space.longitude
      marker.title space.title
      marker.json({title: space.title})
    end
    @user_model = User
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
      marker.title space.title
      marker.infowindow get_marker_info(space)
      marker.json({title: space.title})
    end
    Geocoder.configure(:language  => :en)
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
        format.html { redirect_to @space, flash:{success: t('js.hanted', default: 'Space was hanted.')} }
        format.json { render :show, status: :created, location: @space }
      else
        @spaces = Space.all
        @hash = Gmaps4rails.build_markers(@spaces) do |space, marker|
          marker.lat space.latitude
          marker.lng space.longitude
          marker.title space.title
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
        format.html { redirect_to @space, flash:{success: t('js.updated', default: 'Space was updated.')} }
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
    if Hant.exists?(:space => @space)
      Hant.where(space: @space).delete_all
    end
    respond_to do |format|
      format.html { redirect_to spaces_url, flash:{success: t('js.space_deleted', default: 'Space was deleted.')} }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_space
      if Space.exists?(:id => params[:id])
        @space = Space.find(params[:id])
      else
        redirect_to controller: 'spaces', action: 'new'
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def space_params
      params.require(:space).permit(:title, :address, :latitude, :longitude, :category)
    end

    def authenticate_space_user!
      if @space.user != current_user
        redirect_to @space
      end
    end

    def get_marker_info(space)
      case space.category
      when "cafe"
        gliyphicon = "glyphicon-glass"
      when "library"
        gliyphicon = "glyphicon-book"
      else
        gliyphicon = "glyphicon-globe"
      end
      return "<span class='glyphicon #{gliyphicon}' aria-hidden='true'></span>
              #{t("js.#{space.category}")}<br>
              #{space.title}<br>
              <a class='btn btn-success btn-xs'
              href='#{"/#{I18n.locale}" unless I18n.locale==I18n.default_locale}/spaces/#{space.id}'>
                #{t('js.detail', default: 'Watch the detail')}
              </a>"
    end
end
