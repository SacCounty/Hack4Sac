module UsersHelper
  def email_break_oppty(email_address)
    wbr = "<wbr>"
    prefix, at, suffix = email_address.rpartition("@").reject(&:empty?)
    prefix.gsub!(/(\W)/i){ |char| wbr + char }
    suffix.gsub!(/(\W)/i){ |char| wbr + char }

    (prefix + wbr + at + suffix).html_safe
  end
end
