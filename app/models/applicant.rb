require 'active_resource'
require 'net/http'
class Applicant < ActiveResource::Base
  self.site = "http://tapp-dev1.do.freeatnet.com:3000/"
end