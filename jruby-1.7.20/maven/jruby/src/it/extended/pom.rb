# jruby scripting container
pom 'org.jruby:jruby', '@project.version@'

# unit tests
jar 'junit:junit', '4.8.2', :scope => :test

properties 'tesla.dump.pom' => 'pom.xml', 'tesla.dump.readOnly' => true

plugin :surefire, '2.15', :additionalClasspathElements => [ '${basedir}/../../../../../core/target/test-classes', '${basedir}/../../../../../test/target/test-classes' ]
