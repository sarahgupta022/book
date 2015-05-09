project 'JRuby Main Maven Artifact With ASM Relocated' do

  version = File.read( File.join( basedir, '..', '..', 'VERSION' ) ).strip

  model_version '4.0.0'
  id "org.jruby:jruby-noasm:#{version}"
  inherit "org.jruby:jruby-artifacts:#{version}"
  # keep it a jar even without sources - easier to add in project
  packaging 'bundle'

  properties( 'tesla.dump.pom' => 'pom.xml',
              'tesla.dump.readonly' => true,
              'jruby.home' => '${basedir}/../..',
              'main.basedir' => '${project.parent.parent.basedir}' )

  # the jar with classifier 'noasm' still has the dependencies
  # of the regular artifact and we need to exclude those which
  # are shaded into the 'noasm' artifact
  jar( 'org.jruby:jruby-core:${project.version}:noasm',
       :exclusions => [ 'com.github.jnr:jnr-ffi',
                        'org.ow2.asm:asm',
                        'org.ow2.asm:asm-commons',
                        'org.ow2.asm:asm-analysis',
                        'org.ow2.asm:asm-util' ] )
  jar 'org.jruby:jruby-stdlib:${project.version}'

  # we have no sources and attach an empty jar later in the build to
  # satisfy oss.sonatype.org upload
  plugin( :source, 'skipSource' =>  'true' )

  # this plugin is configured to attach empty jars for sources and javadocs
  plugin( 'org.codehaus.mojo:build-helper-maven-plugin' )

  plugin( :invoker )

  plugin( 'org.apache.felix:maven-bundle-plugin',
          :instructions => {
            'Bundle-Name' => 'JRuby ${project.version}',
            'Bundle-Description' => 'JRuby ${project.version} OSGi bundle',
            'Bundle-SymbolicName' => 'org.jruby.jruby'
          } ) do
    # TODO fix DSL
    @current.extensions = true
  end
end
