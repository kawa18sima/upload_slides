class SlidesController < ApplicationController
  def index
    @slides = []
    slide_path = Dir.glob(Rails.root.join('public', '*.pptx'))
    slide_path.each do |path|
      content = {}
      content[:filepath] = '/'+File.basename(path)
      content[:filename] = File.basename(path)
      @slides.push(content)
    end
  end

  def new
  end

  def create
    slide = slide_params[:file]
    output_path = Rails.root.join('public', slide.original_filename)
    File.open(output_path, 'w+b') do |fp|
      fp.write  slide.read
    end
    redirect_to action: :index
  end

  def download
    send_file(Rails.root.join('public' + params[:id] + "." + params[:format]))
  end

  private

  def slide_params
    params.permit(:file)
  end

end
