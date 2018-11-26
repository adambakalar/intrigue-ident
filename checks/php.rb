module Intrigue
module Ident
module Check
    class Php < Intrigue::Ident::Check::Base

      def generate_checks(url)
        [
          {
            :type => "application",
            :vendor =>"PHP",
            :product =>"PHP",
            :match_details =>"x-powered-by header",
            :version => nil,
            :match_type => :content_headers,
            :match_content =>  /x-powered-by: PHP/i,
            :dynamic_version => lambda { |x|
              _first_header_capture(x,/x-powered-by: PHP\/(.*)/i)
            },
            :paths => ["#{url}"]
          }
        ]
      end

    end
  end
  end
  end
