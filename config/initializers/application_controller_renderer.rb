# Be sure to restart your server when you modify this file.

# ApplicationController.renderer.defaults.merge!(
#   http_host: 'example.org',
#   https: false
# )
module URI

  major, minor, patch = RUBY_VERSION.split('.').map { |v| v.to_i }

  if major == 1 && minor <= 9
    def self.decode_www_form_component(str, enc=nil)
      if TBLDECWWWCOMP_.empty?
        tbl = {}
        256.times do |i|
          h, l = i>>4, i&15
          tbl['%%%X%X' % [h, l]] = i.chr
          tbl['%%%x%X' % [h, l]] = i.chr
          tbl['%%%X%x' % [h, l]] = i.chr
          tbl['%%%x%x' % [h, l]] = i.chr
        end
        tbl['+'] = ' '
        begin
          TBLDECWWWCOMP_.replace(tbl)
          TBLDECWWWCOMP_.freeze
        rescue
        end
      end
      str = str.gsub(/%(?![0-9a-fA-F]{2})/, "%25")
      str.gsub(/\+|%[0-9a-fA-F]{2}/) {|m| TBLDECWWWCOMP_[m]}
    end
  end

end