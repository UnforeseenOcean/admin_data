xml.instruct! :xml, :version => "1.0"
xml.rss(:version => "2.0" ){
  xml.channel{
    xml.title("Feeds from AdminData #{@klass.name}")
    xml.link(request.host_with_port)
    xml.description("feeds from AdminData #{@klass.name}")
    xml.language('en-us')
    h = {:order => "#{@klass.primary_key} desc", :limit => 100}
    @klass.find(:all, h).each do |record|
      xml.item do
        xml.title("#{@klasss} id: #{record.id}")

        desc = admin_data_get_label_values_pair_for(record).inject([]) do |sum, a|
          sum << "<p>#{a[0]}: #{a[1]}</p>"
        end.join

        xml.description(desc)
        xml.pubDate(record.created_at.strftime("%a, %d %b %Y %H:%M:%S %z"))
        xml.link(admin_data_on_k_path(:id => record, :klass => @klass.name))
        xml.guid(admin_data_on_k_path(:id => record, :klass => @klass.name))
      end
    end
  }
}
