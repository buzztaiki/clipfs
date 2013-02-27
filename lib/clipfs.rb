require 'clipboard'
require 'fusefs'

module ClipFS
  class FS < FuseFS::FuseDir
    def contents(path)
      ['clip']
    end
    
    def file?(path)
      path == '/clip'
    end
    
    def read_file(path)
      Clipboard.paste
    end

    def can_write?(path)
      true
    end

    def write_to(path, body)
      Clipboard.copy(body)
    end

    def size(path)
      Clipboard.paste.size
    end
  end

  class Cli
    def die(msg)
    end
    
    def main(argv)
      dir = argv.shift

      abort "Usage: #{$0} DIR" unless dir
      abort "#{dir} is not a directory" unless File.directory?(dir)

      FuseFS.set_root(FS.new)
      FuseFS.mount_under(dir)
      FuseFS.run
    end
  end
end
