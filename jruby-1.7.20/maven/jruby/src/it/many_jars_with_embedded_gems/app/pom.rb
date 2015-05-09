# two jars with embedded gems
jar 'de.saumya.mojo:maven-tools', '0.34.2'
jar 'org.rubygems:zip', '2.0.2'

# jruby scripting container
pom 'org.jruby:jruby', '@project.version@'

# unit tests
jar 'junit:junit', '4.8.2', :scope => :test

resource :directory => "src/main/ruby"
