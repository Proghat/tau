require 'tau/engines/haml'
require 'tau/engines/sass'
require 'tau/engines/scss'
require 'tau/engines/coffee'

module Tau
  class Enginer
    ENGINES = [Engines::Haml, Engines::Sass, Engines::Scss, Engines::Coffee]

    def self.can_render_to?(filename)
      ENGINES.each do |engine|
        return true if engine.can_render_to? filename
      end
      false
    end

    def self.can_render_from?(filename)
      ENGINES.each do |engine|
        return true if engine.can_render_from? filename
      end
      false
    end

    def self.engine_for_render_to(filename)
      ENGINES.select {|engine| engine.can_render_to? filename}.first
    end

    def self.engine_for_render_from(filename)
      ENGINES.select {|engine| engine.can_render_from? filename}.first
    end

    def self.dst_for(source)
      engine = engine_for_render_from source
      engine != nil ? engine.dst_for(source) : source
    end

    def self.source_for(dst)
      engine = engine_for_render_to dst
      engine != nil ? engine.source_for(dst) : dst_for
    end
  end
end
