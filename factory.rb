class Factory
  def self.new (*attrs, &block)
    
    klass = Class.new do
      attr_accessor(*attrs)

      def initialize(*values)
        values.each_index { |index| send("#{members[index]}=", values[index]) }
      end
  
      define_method :members do
        attrs
      end

      def ==(other_obj)
        return false unless self.class == other_obj.class
        return true if values == other_obj.values
        false
      end

      def [](attribute)
        return send("#{members[attribute]}") if attribute.is_a?(Fixnum) 
        send(attribute)
      end

      def []=(attribute, value)
        return send("#{members[attribute]}=", value) if attribute.is_a?(Fixnum) 
        send("#{attribute}=", value)
      end

      def each(&block)
        values.each { |v| block.call(v) }
      end

      def each_pair(&block)
        members.each { |attribute| block.call(attribute, send(attribute)) }
      end

      def values
        values = []
        members.each { |var| values << send(var) }
        return values
      end

      def values_at(*attrs)
        values = []
        attrs.each do |attribute| 
          if attribute.is_a?(Fixnum) 
            values << send("#{members[attribute]}")
          else
            values << send("#{attribute}")
          end
        end
        values
      end

      def inspect
        str = "#<factory "
        members.each do |var|
         str << "#{var}=#{send(var).inspect}, " 
        end
        str.slice!(-2, 2)
        return str << ">"
      end

      def select(&block)
        values.select { |v| block.call(v) }
      end

      def length
        members.size
      end

      class_eval(block) if block_given?

      alias_method :to_a, :values 
      alias_method :to_s, :inspect
      alias_method :eql?, :==
      alias_method :size, :length

    end
  end
end