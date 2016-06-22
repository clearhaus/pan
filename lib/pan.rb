class Pan
  VERSION = '1.0.0'

  singleton_class.class_eval do
    attr_accessor :template
  end

  DEFAULT_TEMPLATE = [6, '*', 4]
  self.template = DEFAULT_TEMPLATE

  class Error < RuntimeError; end

  def self.mask(pan, template: self.template)
    fail Pan::Error, 'invalid template' unless template.first >= 0 and template.last >= 0 and template[1].is_a?(String)
    fail Pan::Error, 'invalid pan' unless pan.is_a?(String)

    mask_length = pan.length - template.first - template.last

    return pan if mask_length <= 0

    pan.slice(0, template.first) \
      + (template[1] * mask_length) \
      + pan.slice(-template.last, template.last)
  end

  def self.truncate(pan, template: self.template)
    pan.replace(self.mask(pan, template: template))
  end
end
