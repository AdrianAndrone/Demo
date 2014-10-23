class FiledownloadsController < ApplicationController

  def download
    @current_course=Course.find(params[:course_id])
    # @current_course.documents.each do |doc|
    #   if doc.file.path.is_a? String
    #     send_file doc.file.path, filename: doc.file_file_name, type: doc.file_content_type, :disposition => 'inline'
    #     flash[:notice] = "Fisierul a fost descarcat."
    #   else
    #     raise 'Nu exista fisier uploadat. Incearca alt document.'
    #   end
    # end
    @document=@current_course.documents.find(params[:id])
    send_file  @document.file.path, filename: @document.file_file_name, type: @document.file_content_type
    flash[:notice]="Fisierul a fost descarcat"
  end

end


