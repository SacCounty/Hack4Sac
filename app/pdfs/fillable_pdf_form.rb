class FillablePdfForm
  attr_writer :template_path
  attr_reader :attributes

  def initialize
    fill_out
  end

  def export(output_file_path=nil)
    # Make sure tmp/pdfs exists
    output_path = output_file_path || "#{Rails.root}/tmp/pdfs/#{SecureRandom.uuid}.pdf"
    pdftk.fill_form template_path, output_path, attributes
    output_path
  end

  def get_field_names
    pdftk.get_field_names template_path
  end

  def template_path
    # Makes assumption about template file path unless otherwise specified
    @template_path ||= "#{Rails.root}/lib/pdf_templates/#{self.class.name.gsub('Pdf', '').underscore}.pdf"
  end

  protected

  def attributes
    @attributes ||= {}
  end

  def fill(key, value)
    attributes[key.to_s] = value
  end

def pdftk
  # Use path stored in Heroku env vars or else get path to local binaries
  @pdftk ||= PdfForms.new(ENV['PDFTK_PATH'] || local_path)
end

def local_path
  os = RbConfig::CONFIG['arch']
  if /mswin/ =~ os
    # Get file/path/to/pdftk on Windows systems
    path = `where pdftk`
  else
    # Get file/path/to/pdftk on POSIX systems
    path = `which pdftk`
  end

  path.strip
end

  def fill_out
    raise 'Must be overridden by child class'
  end

end
