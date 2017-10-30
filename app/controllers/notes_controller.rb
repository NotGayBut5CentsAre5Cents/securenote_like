class NotesController < ApplicationController
  #before_action :set_note, only: [:show, :edit, :update, :destroy]

  # GET /notes
  # GET /notes.json
  def index
    @notes = Note.all
  end

  # GET /notes/1
  # GET /notes/1.json
  def show
    @note = Note.find_by slug: params[:slug]
    if @note.nil?
      render "note_gone"
    else
      @note.destroy
    end
  end

  # GET /notes/new
  def new
    @note = Note.new
  end

  # GET /notes/1/edit
  def edit
  end

  # POST /notes
  # POST /notes.json
  def create
    respond_to do |format|
      note = Note.create(content: params[:message])
      format.xml {
        render :xml => {url: notes_url + note.slug + '/info'}.to_xml
      }
      format.json {
        render :json => {url: notes_url + note.slug + '/info'} 
      }
      format.html {
        @note = Note.new({content: params[:content]})
        if @note.save
          redirect_to notes_url + @note.slug + '/info'
        else
          render 'index'
        end
      }
    end
    
  end

  def info
    render "note_url_info", locals: {url: notes_url + "/" + params[:slug]}
  end

  # PATCH/PUT /notes/1
  # PATCH/PUT /notes/1.json
  def update
    respond_to do |format|
      if @note.update(note_params)
        format.html { redirect_to @note, notice: 'Note was successfully updated.' }
        format.json { render :show, status: :ok, location: @note }
      else
        format.html { render :edit }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notes/1
  # DELETE /notes/1.json
  def destroy
    @note.destroy
    respond_to do |format|
      format.html { redirect_to notes_url, notice: 'Note was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_note
      @note = Note.find(params[:slug])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def note_params
      params.require(:note).permit(:content)
    end
end
