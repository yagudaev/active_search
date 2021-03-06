class PagesController < ApplicationController
  before_action :set_page, only: [:show, :edit, :update, :destroy]

  # GET /pages
  # GET /pages.json
  def index
    if params[:q].present?
      @results = Page.search(query: { fuzzy: { content: { value: params[:q] } } }, highlight: { fields: { content: {} } })
      @has_highlights = true
    else
      @results = Page.search('*')
    end
    @pages = @results.records
  end

  # GET /pages/1
  # GET /pages/1.json
  def show
  end

  # GET /pages/new
  def new
    @page = Page.new
  end

  # GET /pages/1/edit
  def edit
  end

  # POST /pages
  # POST /pages.json
  def create
    @page = Page.new(page_params)

    respond_to do |format|
      if @page.save
        format.html { redirect_to @page, notice: 'Page was successfully created.' }
        format.json { render :show, status: :created, location: @page }
      else
        format.html { render :new }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pages/1
  # PATCH/PUT /pages/1.json
  def update
    respond_to do |format|
      if @page.update(page_params)
        format.html { redirect_to @page, notice: 'Page was successfully updated.' }
        format.json { render :show, status: :ok, location: @page }
      else
        format.html { render :edit }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pages/1
  # DELETE /pages/1.json
  def destroy
    @page.destroy
    respond_to do |format|
      format.html { redirect_to pages_url, notice: 'Page was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def import
    Page.destroy_all
    Dir.glob('db/docs/markdown/*').each do |file_path|
      Page.create(link: "/#{File.basename(file_path, '.md')}", content: open(file_path).read)
    end

    Dir.glob('public/rdoc/**/*.html').each do |file_path|
      link = file_path.gsub(/^public/, '')
      text = Nokogiri::HTML(File.open(file_path)).text
      Page.create(link: link, content: text)
    end

    render plain: "Imported successfully! Created #{Page.count} pages"
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_page
    @page = Page.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def page_params
    params.require(:page).permit(:link, :content)
  end
end
