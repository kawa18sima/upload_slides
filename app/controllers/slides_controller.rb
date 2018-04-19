class SlidesController < ApplicationController
  def index
    @slides =[]
    slides = Slide.order("created_at DESC")
    slides.each do |slide|
      content = {}
      content[:filepath] = Dir.glob(Rails.root.join('public', slide.title))[0]
      content[:filename] = slide.title
      content[:name] = slide.name
      @slides.push(content)
    end
  end

  def new
  end

  def create
    slide = params[:file]
    output_path = Rails.root.join('public', slide.original_filename)
    File.open(output_path, 'w+b') do |fp|
      fp.write  slide.read
    end
    slides = slide_params(slide.original_filename)
    @slides = Slide.find_or_create_by(slides)
    if @slides.name == ""
      @slides.name = "名無しさん"
    end
    if @slides.save
        redirect_to action: :index
    else
        render :new
    end
  end

  def download
    send_file(Rails.root.join(params[:id] + "." + params[:format]))
  end

  private

  def slide_params(name)
    params.permit(:name).merge(title: name)
  end

end
