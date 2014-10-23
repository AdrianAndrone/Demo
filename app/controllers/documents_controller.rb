class DocumentsController < ApplicationController

  def new
    @document=Document.new
  end

  def index
    @course=Course.find(params[:course_id])
    @documents=@course.documents.all
  end

  def create
    @course=Course.find params[:course_id]
    @document=@course.documents.build(params[:document])
    if @document.save
      redirect_to  @course
    elsif
      raise 'Alege un format corespunzator.Poti alege PDF sau WORD.'
    else
      render 'new'
    end

  end

  def destroy
    @course=Course.find params[:course_id]
    @document=@course.documents.find params[:id]
    @document.destroy
    redirect_to @course
  end

  def show
    @course=Course.find params[:course_id]
    @document=@course.documents.find(params[:id])
    send_file(@document.file.path, :type => 'application/pdf', :disposition => 'inline')
   # prawnto :prawn => {
   # :left_margin => 20,
   # :right_margin => 20
   # }
    #@reader=PDF::Reader.new(@document.file.path).pages
    #File.read(@document.file.path).force_encoding("ISO-8859-1").encode("utf-8", replace: nil)
  end

end

