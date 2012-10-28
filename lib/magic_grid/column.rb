module MagicGrid
  class Column
    extend Forwardable
    def_delegators :@col, :[], :key?, :has_key?

    def initialize(collection, c, i)
      @collection = collection
      @col = case c
              when Symbol
                {col: c}
              when String
                {label: c}
              else
                c
              end
      @col[:id] = i
      if @col.key?(:col) and @col[:col].is_a?(Symbol) and @collection.column_names(i).include?(@col[:col])
        @col[:sql] = "#{@collection.quoted_table_name}.#{@collection.quote_column_name(@col[:col].to_s)}" unless @col.key?(:sql)
      end
      @col[:label] ||= @col[:col].to_s.titleize
    end

  end
end