module Intrigue
module Ident
module Check
class Amazon < Intrigue::Ident::Check::Base

  def generate_checks(url)
    [
      {
        type: "fingerprint",
        category: "service",
        tags: ["Load Balancer", "Hosting", "WAF", "IaaS"],
        website: "https://aws.amazon.com/blogs/aws/aws-web-application-firewall-waf-for-application-load-balancers/",
        references: ["https://stackoverflow.com/questions/49197688/is-the-most-recent-awsalb-cookie-required-aws-elb-application-load-balancer"],
        vendor: "Amazon",
        product: "Application Load Balancer",
        version: nil,
        match_type: :content_cookies,
        match_content:  /AWSALB=/,
        description:"amazon App LB cookie (sticky sessions)",
        hide: false,
        paths: [ { path: "#{url}", follow_redirects: true } ],
        inference: false
      },
      {
        type: "fingerprint",
        category: "service",
        tags: ["CDN", "Hosting", "WAF", "IaaS"],
        vendor: "Amazon",
        product:"Cloudfront",
        version: nil,
        description:"cloudfront cache header",
        match_type: :content_headers,
        match_content:  /via:.*.cloudfront.net \(CloudFront\)/,
        hide: false,
        paths: [ { path: "#{url}", follow_redirects: true } ],
        inference: false
      },
      {
        type: "fingerprint",
        category: "service",
        tags: ["CDN", "Hosting", "WAF", "IaaS"],
        vendor: "Amazon",
        product:"Cloudfront",
        version: nil,
        description:"cloudfront cache header",
        match_type: :content_headers,
        match_content:  /x-cache:.*cloudfront/i,
        hide: false,
        paths: [ { path: "#{url}", follow_redirects: true } ],
        inference: false
      },
      {
        type: "fingerprint",
        category: "service",
        tags: ["CDN", "Hosting","WAF", "IaaS"],
        vendor: "Amazon",
        product:"Cloudfront",
        description:"no configured hostname error condition",
        version: nil,
        match_type: :content_body,
        match_content: /ERROR: The request could not be satisfied/,
        dynamic_hide: lambda{ |x| 
          return true if _uri_match(x,/cloudfront.net/)       || 
                         _uri_match(x,/\d+.\d+.\d+.\d+:/) 
        },
        paths: [ { path: "#{url}", follow_redirects: true } ],
        inference: false
      },
      {
        type: "fingerprint",
        category: "service",
        tags: ["CDN", "Hosting","WAF", "IaaS"],
        vendor: "Amazon",
        product:"Cloudfront",
        description:"cloudfront error",
        version: nil,
        match_type: :content_body,
        match_content: /If you provide content to customers through CloudFront, you can find steps to troubleshoot and help prevent this error by reviewing the CloudFront documentation./im,
        dynamic_hide: lambda{ |x| 
          return true if _uri_match(x,/cloudfront.net/)       || 
                         _uri_match(x,/\d+.\d+.\d+.\d+:/) 
        },
        paths: [ { path: "#{url}", follow_redirects: true } ],
        inference: false
      },
      {
        type: "fingerprint",
        category: "service",
        tags: ["CDN", "Hosting","WAF", "IaaS"],
        vendor: "Amazon",
        product:"Cloudfront",
        description:"Cloudfront 403",
        version: nil,
        match_type: :content_body,
        match_content: /<H1>403 ERROR<\/H1>\n<H2>The request could not be satisfied.<\/H2>\n.*Generated by cloudfront \(CloudFront\)/im,
        dynamic_hide: lambda{ |x| 
          return true if _uri_match(x,/cloudfront.net/)       || 
                         _uri_match(x,/\d+.\d+.\d+.\d+:/) 
        },
        paths: [ { path: "#{url}", follow_redirects: true } ],
        inference: false
      },
      {
        type: "fingerprint",
        category: "service",
        tags: ["CDN", "Hosting","WAF", "IaaS"],
        vendor: "Amazon",
        product:"Cloudfront",
        description:"generic error",
        version: nil,
        match_type: :content_headers,
        match_content:  /Error from cloudfront/,
        dynamic_hide: lambda{ |x| 
          return true if _uri_match(x,/cloudfront.net/)       || 
                         _uri_match(x,/\d+.\d+.\d+.\d+:/) 
        },
        paths: [ { path: "#{url}", follow_redirects: true } ],
        inference: false
      },
      {
        type: "fingerprint",
        category: "service",
        tags: ["CDN", "Hosting","WAF", "IaaS"],
        vendor: "Amazon",
        product:"Cloudfront",
        description:"x-amz-cf-pop header",
        version: nil,
        match_type: :content_headers,
        match_content:  /^x-amz-cf-pop:.*/i,
        hide: false,
        paths: [ { path: "#{url}", follow_redirects: true } ],
        inference: false
      },
      { 
        type: "fingerprint",
        category: "service",
        tags: ["CDN", "Hosting","WAF", "IaaS"],
        vendor: "Amazon",
        product:"Cloudfront",
        description:"x-amz-cf-id header",
        version: nil,
        match_type: :content_headers,
        match_content:  /^x-amz-cf-id:.*/i,
        hide: false,
        paths: [ { path: "#{url}", follow_redirects: true } ],
        inference: false
      },
      {
        type: "fingerprint",
        category: "service",
        tags: ["CDN", "Hosting", "WAF", "IaaS"],
        vendor: "Amazon",
        product:"Cloudfront",
        description:"generic error",
        version: nil,
        match_type: :content_headers,
        match_content: /^x-cache: Error from cloudfront$/i,
        dynamic_hide: lambda{ |x| 
          return true if _uri_match(x,/cloudfront.net/)       || 
                         _uri_match(x,/\d+.\d+.\d+.\d+:/) 
        },
        paths: [ { path: "#{url}", follow_redirects: true } ],
        inference: false
      },
      {
        type: "fingerprint",
        category: "service",
        tags: ["CDN", "Hosting", "WAF", "IaaS"],
        vendor: "Amazon",
        product:"Cloudfront",
        description:"403 error condition",
        version: nil,
        match_type: :content_body,
        match_content: /<h1>403 Forbidden<\/h1><\/center>\n<hr><center>cloudfront/,
        dynamic_hide: lambda{ |x| 
          return true if _uri_match(x,/cloudfront.net/)       || 
                         _uri_match(x,/\d+.\d+.\d+.\d+:/) 
        },
        paths: [ { path: "#{url}", follow_redirects: true } ],
        inference: false
      },
      {
        type: "fingerprint",
        category: "service",
        tags: ["Load Balancer", "Hosting", "IaaS"],
        website: "https://aws.amazon.com/elasticloadbalancing/",
        vendor: "Amazon",
        product: "Elastic Load Balancer",
        version: nil,
        match_type: :content_headers,
        match_content:  /awselb\/\d.\d/,
        description:"error page",
        dynamic_hide: lambda{ |x| 
          return true if _uri_match(x,/amazonaws.com/)       || 
                         _uri_match(x,/\d+.\d+.\d+.\d+:/) 
        },
        dynamic_version: lambda { |x| _first_header_capture(x,/awselb\/(\d.\d)/) },
        paths: [ { path: "#{url}", follow_redirects: true } ],
        inference: false
      },
      {
        type: "fingerprint",
        category: "service",
        tags: ["Load Balancer", "Hosting", "IaaS"],
        website: "https://aws.amazon.com/elasticloadbalancing/",
        vendor: "Amazon",
        product: "Elastic Load Balancer",
        match_type: :content_cookies,
        match_content:  /AWSELB=/,
        description:"amazon elastic cookie (AWSELB)",
        hide: false,
        paths: [ { path: "#{url}", follow_redirects: true } ],
        inference: false
      },
      {
        type: "fingerprint",
        category: "service",
        tags: ["Load Balancer", "Hosting", "IaaS"],
        website: "https://aws.amazon.com/elasticloadbalancing/",
        vendor: "Amazon",
        references: ["https://stackoverflow.com/questions/49197688/is-the-most-recent-awsalb-cookie-required-aws-elb-application-load-balancer"],
        product: "Elastic Load Balancer",
        match_type: :content_cookies,
        match_content:  /AWSALBTG=/,
        description:"Amazon elastic cookie (AWSALBTG)",
        hide: false,
        paths: [ { path: "#{url}", follow_redirects: true } ],
        inference: false
      },
      {
        type: "fingerprint",
        category: "operating_system",
        tags: ["OS", "IaaS"],
        vendor: "Amazon",
        product:"Linux",
        description:"nginx test page",
        match_type: :content_title,
        match_content: /^Test Page for the Nginx HTTP Server on the Amazon Linux AMI$/,
        hide: false,
        paths: [ { path: "#{url}", follow_redirects: true } ],
        inference: false
      },
      {
        type: "fingerprint",
        category: "operating_system",
        tags: ["OS", "IaaS"],
        vendor: "Amazon",
        product:"Linux",
        description:"nginx test page",
        version: nil,
        match_type: :content_title,
        match_content: /^Test Page for the Nginx HTTP Server on Amazon Linux$/,
        hide: false,
        paths: [ { path: "#{url}", follow_redirects: true } ],
        inference: false
      },
      {
        type: "fingerprint",
        category: "service",
        tags: ["WebServer", "Hosting", "IaaS"],
        vendor: "Amazon",
        product:"S3",
        description:"server header",
        version: nil,
        match_type: :content_headers,
        match_content: /server: AmazonS3/i,
        hide: false,
        paths: [ { path: "#{url}", follow_redirects: true } ],
        inference: false
      },
      {
        type: "fingerprint",
        category: "service",
        tags: ["WebServer", "Hosting", "IaaS"],
        vendor: "Amazon",
        product:"S3",
        description:"replication status header",
        version: nil,
        match_type: :content_headers,
        match_content: /^x-amz-replication-status: .*$/i,
        hide: false,
        paths: [ { path: "#{url}", follow_redirects: true } ],
        inference: false
      }
    ]
  end
end
end
end
end
