#
# DO NOT MODIFY!!!!
# This file is automatically generated by racc 1.4.3
# from racc grammer file "parser.y".
#
#
# parser.rb: generated by racc (runtime embedded)
#

###### racc/parser.rb

unless $".index 'racc/parser.rb'
$".push 'racc/parser.rb'

self.class.module_eval <<'..end /home/aamine/lib/ruby/racc/parser.rb modeval..idb76f2e220d', '/home/aamine/lib/ruby/racc/parser.rb', 1
#
# parser.rb
#
#   Copyright (c) 1999-2003 Minero Aoki <aamine@loveruby.net>
#
#   This program is free software.
#   You can distribute/modify this program under the same terms of ruby.
#
#   As a special exception, when this code is copied by Racc
#   into a Racc output file, you may use that output file
#   without restriction.
#
#   $Id: parser.rb,v 1.1.1.1 2004/10/14 11:59:58 webster132 Exp $
#

unless defined? NotImplementedError
  NotImplementedError = NotImplementError
end


module Racc
  class ParseError < StandardError; end
end
unless defined?(::ParseError)
  ParseError = Racc::ParseError
end


module Racc

  unless defined? Racc_No_Extentions
    Racc_No_Extentions = false
  end

  class Parser

    Racc_Runtime_Version = '1.4.3'
    Racc_Runtime_Revision = '$Revision: 1.1.1.1 $'.split(/\s+/)[1]

    Racc_Runtime_Core_Version_R = '1.4.3'
    Racc_Runtime_Core_Revision_R = '$Revision: 1.1.1.1 $'.split(/\s+/)[1]
    begin
      require 'racc/cparse'
    # Racc_Runtime_Core_Version_C  = (defined in extention)
      Racc_Runtime_Core_Revision_C = Racc_Runtime_Core_Id_C.split(/\s+/)[2]
      unless new.respond_to?(:_racc_do_parse_c, true)
        raise LoadError, 'old cparse.so'
      end
      if Racc_No_Extentions
        raise LoadError, 'selecting ruby version of racc runtime core'
      end

      Racc_Main_Parsing_Routine    = :_racc_do_parse_c
      Racc_YY_Parse_Method         = :_racc_yyparse_c
      Racc_Runtime_Core_Version    = Racc_Runtime_Core_Version_C
      Racc_Runtime_Core_Revision   = Racc_Runtime_Core_Revision_C
      Racc_Runtime_Type            = 'c'
    rescue LoadError
      Racc_Main_Parsing_Routine    = :_racc_do_parse_rb
      Racc_YY_Parse_Method         = :_racc_yyparse_rb
      Racc_Runtime_Core_Version    = Racc_Runtime_Core_Version_R
      Racc_Runtime_Core_Revision   = Racc_Runtime_Core_Revision_R
      Racc_Runtime_Type            = 'ruby'
    end

    def self.racc_runtime_type
      Racc_Runtime_Type
    end

    private

    def _racc_setup
      @yydebug = false unless self.class::Racc_debug_parser
      @yydebug = false unless defined? @yydebug
      if @yydebug
        @racc_debug_out = $stderr unless defined? @racc_debug_out
        @racc_debug_out ||= $stderr
      end
      arg = self.class::Racc_arg
      arg[13] = true if arg.size < 14
      arg
    end

    def _racc_init_sysvars
      @racc_state  = [0]
      @racc_tstack = []
      @racc_vstack = []

      @racc_t = nil
      @racc_val = nil

      @racc_read_next = true

      @racc_user_yyerror = false
      @racc_error_status = 0
    end


    ###
    ### do_parse
    ###

    def do_parse
      __send__ Racc_Main_Parsing_Routine, _racc_setup(), false
    end

    def next_token
      raise NotImplementedError, "#{self.class}\#next_token is not defined"
    end

    def _racc_do_parse_rb( arg, in_debug )
      action_table, action_check, action_default, action_pointer,
      goto_table,   goto_check,   goto_default,   goto_pointer,
      nt_base,      reduce_table, token_table,    shift_n,
      reduce_n,     use_result,   * = arg

      _racc_init_sysvars
      tok = act = i = nil
      nerr = 0

      catch(:racc_end_parse) {
          while true
            if i = action_pointer[@racc_state[-1]]
              if @racc_read_next
                if @racc_t != 0   # not EOF
                  tok, @racc_val = next_token()
                  unless tok      # EOF
                    @racc_t = 0
                  else
                    @racc_t = (token_table[tok] or 1)   # error token
                  end
                  racc_read_token(@racc_t, tok, @racc_val) if @yydebug
                  @racc_read_next = false
                end
              end
              i += @racc_t
              if  i >= 0 and
                  act = action_table[i] and
                  action_check[i] == @racc_state[-1]
                ;
              else
                act = action_default[@racc_state[-1]]
              end
            else
              act = action_default[@racc_state[-1]]
            end
            while act = _racc_evalact(act, arg)
            end
          end
      }
    end


    ###
    ### yyparse
    ###

    def yyparse( recv, mid )
      __send__ Racc_YY_Parse_Method, recv, mid, _racc_setup(), true
    end

    def _racc_yyparse_rb( recv, mid, arg, c_debug )
      action_table, action_check, action_default, action_pointer,
      goto_table,   goto_check,   goto_default,   goto_pointer,
      nt_base,      reduce_table, token_table,    shift_n,
      reduce_n,     use_result,   * = arg

      _racc_init_sysvars
      tok = nil
      act = nil
      i = nil
      nerr = 0


      catch(:racc_end_parse) {
        until i = action_pointer[@racc_state[-1]]
          while act = _racc_evalact(action_default[@racc_state[-1]], arg)
          end
        end

        recv.__send__(mid) do |tok, val|
# $stderr.puts "rd: tok=#{tok}, val=#{val}"
          unless tok
            @racc_t = 0
          else
            @racc_t = (token_table[tok] or 1)   # error token
          end
          @racc_val = val
          @racc_read_next = false

          i += @racc_t
          if  i >= 0 and
              act = action_table[i] and
              action_check[i] == @racc_state[-1]
            ;
# $stderr.puts "01: act=#{act}"
          else
            act = action_default[@racc_state[-1]]
# $stderr.puts "02: act=#{act}"
# $stderr.puts "curstate=#{@racc_state[-1]}"
          end

          while act = _racc_evalact(act, arg)
          end

          while not (i = action_pointer[@racc_state[-1]]) or
                not @racc_read_next or
                @racc_t == 0   # $
            if i and i += @racc_t and
               i >= 0 and
               act = action_table[i] and
               action_check[i] == @racc_state[-1]
              ;
# $stderr.puts "03: act=#{act}"
            else
# $stderr.puts "04: act=#{act}"
              act = action_default[@racc_state[-1]]
            end

            while act = _racc_evalact(act, arg)
            end
          end
        end
      }
    end


    ###
    ### common
    ###

    def _racc_evalact( act, arg )
# $stderr.puts "ea: act=#{act}"
      action_table, action_check, action_default, action_pointer,
      goto_table,   goto_check,   goto_default,   goto_pointer,
      nt_base,      reduce_table, token_table,    shift_n,
      reduce_n,     use_result,   * = arg
nerr = 0   # tmp

      if act > 0 and act < shift_n
        #
        # shift
        #

        if @racc_error_status > 0
          @racc_error_status -= 1 unless @racc_t == 1   # error token
        end

        @racc_vstack.push @racc_val
        @racc_state.push act
        @racc_read_next = true

        if @yydebug
          @racc_tstack.push @racc_t
          racc_shift @racc_t, @racc_tstack, @racc_vstack
        end

      elsif act < 0 and act > -reduce_n
        #
        # reduce
        #

        code = catch(:racc_jump) {
            @racc_state.push _racc_do_reduce(arg, act)
            false
        }
        if code
          case code
          when 1 # yyerror
            @racc_user_yyerror = true   # user_yyerror
            return -reduce_n
          when 2 # yyaccept
            return shift_n
          else
            raise RuntimeError, '[Racc Bug] unknown jump code'
          end
        end

      elsif act == shift_n
        #
        # accept
        #

        racc_accept if @yydebug
        throw :racc_end_parse, @racc_vstack[0]

      elsif act == -reduce_n
        #
        # error
        #

        case @racc_error_status
        when 0
          unless arg[21]    # user_yyerror
            nerr += 1
            on_error @racc_t, @racc_val, @racc_vstack
          end
        when 3
          if @racc_t == 0   # is $
            throw :racc_end_parse, nil
          end
          @racc_read_next = true
        end
        @racc_user_yyerror = false
        @racc_error_status = 3

        while true
          if i = action_pointer[@racc_state[-1]]
            i += 1   # error token
            if  i >= 0 and
                (act = action_table[i]) and
                action_check[i] == @racc_state[-1]
              break
            end
          end

          throw :racc_end_parse, nil if @racc_state.size < 2
          @racc_state.pop
          @racc_vstack.pop
          if @yydebug
            @racc_tstack.pop
            racc_e_pop @racc_state, @racc_tstack, @racc_vstack
          end
        end

        return act

      else
        raise RuntimeError, "[Racc Bug] unknown action #{act.inspect}"
      end

      racc_next_state(@racc_state[-1], @racc_state) if @yydebug

      nil
    end

    def _racc_do_reduce( arg, act )
      action_table, action_check, action_default, action_pointer,
      goto_table,   goto_check,   goto_default,   goto_pointer,
      nt_base,      reduce_table, token_table,    shift_n,
      reduce_n,     use_result,   * = arg
      state = @racc_state
      vstack = @racc_vstack
      tstack = @racc_tstack

      i = act * -3
      len       = reduce_table[i]
      reduce_to = reduce_table[i+1]
      method_id = reduce_table[i+2]
      void_array = []

      tmp_t = tstack[-len, len] if @yydebug
      tmp_v = vstack[-len, len]
      tstack[-len, len] = void_array if @yydebug
      vstack[-len, len] = void_array
      state[-len, len]  = void_array

      # tstack must be updated AFTER method call
      if use_result
        vstack.push __send__(method_id, tmp_v, vstack, tmp_v[0])
      else
        vstack.push __send__(method_id, tmp_v, vstack)
      end
      tstack.push reduce_to

      racc_reduce(tmp_t, reduce_to, tstack, vstack) if @yydebug

      k1 = reduce_to - nt_base
      if i = goto_pointer[k1]
        i += state[-1]
        if i >= 0 and (curstate = goto_table[i]) and goto_check[i] == k1
          return curstate
        end
      end
      goto_default[k1]
    end

    def on_error( t, val, vstack )
      raise ParseError, sprintf("\nparse error on value %s (%s)",
                                val.inspect, token_to_str(t) || '?')
    end

    def yyerror
      throw :racc_jump, 1
    end

    def yyaccept
      throw :racc_jump, 2
    end

    def yyerrok
      @racc_error_status = 0
    end


    # for debugging output

    def racc_read_token( t, tok, val )
      @racc_debug_out.print 'read    '
      @racc_debug_out.print tok.inspect, '(', racc_token2str(t), ') '
      @racc_debug_out.puts val.inspect
      @racc_debug_out.puts
    end

    def racc_shift( tok, tstack, vstack )
      @racc_debug_out.puts "shift   #{racc_token2str tok}"
      racc_print_stacks tstack, vstack
      @racc_debug_out.puts
    end

    def racc_reduce( toks, sim, tstack, vstack )
      out = @racc_debug_out
      out.print 'reduce '
      if toks.empty?
        out.print ' <none>'
      else
        toks.each {|t| out.print ' ', racc_token2str(t) }
      end
      out.puts " --> #{racc_token2str(sim)}"

      racc_print_stacks tstack, vstack
      @racc_debug_out.puts
    end

    def racc_accept
      @racc_debug_out.puts 'accept'
      @racc_debug_out.puts
    end

    def racc_e_pop( state, tstack, vstack )
      @racc_debug_out.puts 'error recovering mode: pop token'
      racc_print_states state
      racc_print_stacks tstack, vstack
      @racc_debug_out.puts
    end

    def racc_next_state( curstate, state )
      @racc_debug_out.puts  "goto    #{curstate}"
      racc_print_states state
      @racc_debug_out.puts
    end

    def racc_print_stacks( t, v )
      out = @racc_debug_out
      out.print '        ['
      t.each_index do |i|
        out.print ' (', racc_token2str(t[i]), ' ', v[i].inspect, ')'
      end
      out.puts ' ]'
    end

    def racc_print_states( s )
      out = @racc_debug_out
      out.print '        ['
      s.each {|st| out.print ' ', st }
      out.puts ' ]'
    end

    def racc_token2str( tok )
      self.class::Racc_token_to_s_table[tok] or
          raise RuntimeError, "[Racc Bug] can't convert token #{tok} to string"
    end

    def token_to_str( t )
      self.class::Racc_token_to_s_table[t]
    end

  end

end
..end /home/aamine/lib/ruby/racc/parser.rb modeval..idb76f2e220d
end   # end of racc/parser.rb


#
# parser.rb
#
# Copyright (c) 1998-2003 Minero Aoki <aamine@loveruby.net>
#
# This program is free software.
# You can distribute/modify this program under the terms of
# the GNU Lesser General Public License version 2 or later.
#

require 'tmail/scanner'
require 'tmail/utils'


module TMail

  class Parser < Racc::Parser

module_eval <<'..end parser.y modeval..id43721faf1c', 'parser.y', 331

  include TextUtils

  def self.parse( ident, str, cmt = nil )
    new.parse(ident, str, cmt)
  end

  MAILP_DEBUG = false

  def initialize
    self.debug = MAILP_DEBUG
  end

  def debug=( flag )
    @yydebug = flag && Racc_debug_parser
    @scanner_debug = flag
  end

  def debug
    @yydebug
  end

  def parse( ident, str, comments = nil )
    @scanner = Scanner.new(str, ident, comments)
    @scanner.debug = @scanner_debug
    @first = [ident, ident]
    result = yyparse(self, :parse_in)
    comments.map! {|c| to_kcode(c) } if comments
    result
  end

  private

  def parse_in( &block )
    yield @first
    @scanner.scan(&block)
  end

  def on_error( t, val, vstack )
    raise SyntaxError, "parse error on token #{racc_token2str t}"
  end

..end parser.y modeval..id43721faf1c

##### racc 1.4.3 generates ###

racc_reduce_table = [
 0, 0, :racc_error,
 2, 35, :_reduce_1,
 2, 35, :_reduce_2,
 2, 35, :_reduce_3,
 2, 35, :_reduce_4,
 2, 35, :_reduce_5,
 2, 35, :_reduce_6,
 2, 35, :_reduce_7,
 2, 35, :_reduce_8,
 2, 35, :_reduce_9,
 2, 35, :_reduce_10,
 2, 35, :_reduce_11,
 2, 35, :_reduce_12,
 6, 36, :_reduce_13,
 0, 48, :_reduce_none,
 2, 48, :_reduce_none,
 3, 49, :_reduce_16,
 5, 49, :_reduce_17,
 1, 50, :_reduce_18,
 7, 37, :_reduce_19,
 0, 51, :_reduce_none,
 2, 51, :_reduce_21,
 0, 52, :_reduce_none,
 2, 52, :_reduce_23,
 1, 58, :_reduce_24,
 3, 58, :_reduce_25,
 2, 58, :_reduce_26,
 0, 53, :_reduce_none,
 2, 53, :_reduce_28,
 0, 54, :_reduce_29,
 3, 54, :_reduce_30,
 0, 55, :_reduce_none,
 2, 55, :_reduce_32,
 2, 55, :_reduce_33,
 0, 56, :_reduce_none,
 2, 56, :_reduce_35,
 1, 61, :_reduce_36,
 1, 61, :_reduce_37,
 0, 57, :_reduce_none,
 2, 57, :_reduce_39,
 1, 38, :_reduce_none,
 1, 38, :_reduce_none,
 3, 38, :_reduce_none,
 1, 46, :_reduce_none,
 1, 46, :_reduce_none,
 1, 46, :_reduce_none,
 1, 39, :_reduce_none,
 2, 39, :_reduce_47,
 1, 64, :_reduce_48,
 3, 64, :_reduce_49,
 1, 68, :_reduce_none,
 1, 68, :_reduce_none,
 1, 69, :_reduce_52,
 3, 69, :_reduce_53,
 1, 47, :_reduce_none,
 1, 47, :_reduce_none,
 2, 47, :_reduce_56,
 2, 67, :_reduce_none,
 3, 65, :_reduce_58,
 2, 65, :_reduce_59,
 1, 70, :_reduce_60,
 2, 70, :_reduce_61,
 4, 62, :_reduce_62,
 3, 62, :_reduce_63,
 2, 72, :_reduce_none,
 2, 73, :_reduce_65,
 4, 73, :_reduce_66,
 3, 63, :_reduce_67,
 1, 63, :_reduce_68,
 1, 74, :_reduce_none,
 2, 74, :_reduce_70,
 1, 71, :_reduce_71,
 3, 71, :_reduce_72,
 1, 59, :_reduce_73,
 3, 59, :_reduce_74,
 1, 76, :_reduce_75,
 2, 76, :_reduce_76,
 1, 75, :_reduce_none,
 1, 75, :_reduce_none,
 1, 75, :_reduce_none,
 1, 77, :_reduce_none,
 1, 77, :_reduce_none,
 1, 77, :_reduce_none,
 1, 66, :_reduce_none,
 2, 66, :_reduce_none,
 3, 60, :_reduce_85,
 1, 40, :_reduce_86,
 3, 40, :_reduce_87,
 1, 79, :_reduce_none,
 2, 79, :_reduce_89,
 1, 41, :_reduce_90,
 2, 41, :_reduce_91,
 3, 42, :_reduce_92,
 5, 43, :_reduce_93,
 3, 43, :_reduce_94,
 0, 80, :_reduce_95,
 5, 80, :_reduce_96,
 1, 82, :_reduce_none,
 1, 82, :_reduce_none,
 1, 44, :_reduce_99,
 3, 45, :_reduce_100,
 0, 81, :_reduce_none,
 1, 81, :_reduce_none,
 1, 78, :_reduce_none,
 1, 78, :_reduce_none,
 1, 78, :_reduce_none,
 1, 78, :_reduce_none,
 1, 78, :_reduce_none,
 1, 78, :_reduce_none,
 1, 78, :_reduce_none ]

racc_reduce_n = 110

racc_shift_n = 168

racc_action_table = [
   -70,   -69,    23,    25,   146,   147,    29,    31,   105,   106,
    16,    17,    20,    22,   136,    27,   -70,   -69,    32,   101,
   -70,   -69,   154,   100,   113,   115,   -70,   -69,   -70,   109,
    75,    23,    25,   101,   155,    29,    31,   142,   143,    16,
    17,    20,    22,   107,    27,    23,    25,    32,    98,    29,
    31,    96,    94,    16,    17,    20,    22,    78,    27,    23,
    25,    32,   112,    29,    31,    74,    91,    16,    17,    20,
    22,    88,   117,    92,    81,    32,    23,    25,    80,   123,
    29,    31,   100,   125,    16,    17,    20,    22,   126,    23,
    25,   109,    32,    29,    31,    91,   128,    16,    17,    20,
    22,   129,    27,    23,    25,    32,   101,    29,    31,   101,
   130,    16,    17,    20,    22,    79,    52,    23,    25,    32,
    78,    29,    31,   133,    78,    16,    17,    20,    22,    77,
    23,    25,    75,    32,    29,    31,    65,    62,    16,    17,
    20,    22,   139,    23,    25,   101,    32,    29,    31,    60,
   100,    16,    17,    20,    22,    44,    27,   101,   148,    32,
    23,    25,   120,   149,    29,    31,   152,   153,    16,    17,
    20,    22,    42,    27,   157,   159,    32,    23,    25,   120,
    40,    29,    31,    15,   164,    16,    17,    20,    22,    40,
    27,    23,    25,    32,    68,    29,    31,   166,   167,    16,
    17,    20,    22,   nil,    27,    23,    25,    32,   nil,    29,
    31,    74,   nil,    16,    17,    20,    22,   nil,    23,    25,
   nil,    32,    29,    31,   nil,   nil,    16,    17,    20,    22,
   nil,    23,    25,   nil,    32,    29,    31,   nil,   nil,    16,
    17,    20,    22,   nil,    23,    25,   nil,    32,    29,    31,
   nil,   nil,    16,    17,    20,    22,   nil,    23,    25,   nil,
    32,    29,    31,   nil,   nil,    16,    17,    20,    22,   nil,
    27,    23,    25,    32,   nil,    29,    31,   nil,   nil,    16,
    17,    20,    22,   nil,    23,    25,   nil,    32,    29,    31,
   nil,   nil,    16,    17,    20,    22,   nil,    23,    25,   nil,
    32,    29,    31,   nil,   nil,    16,    17,    20,    22,   nil,
    84,    25,   nil,    32,    29,    31,   nil,    87,    16,    17,
    20,    22,     4,     6,     7,     8,     9,    10,    11,    12,
    13,     1,     2,     3,    84,    25,   nil,   nil,    29,    31,
   nil,    87,    16,    17,    20,    22,    84,    25,   nil,   nil,
    29,    31,   nil,    87,    16,    17,    20,    22,    84,    25,
   nil,   nil,    29,    31,   nil,    87,    16,    17,    20,    22,
    84,    25,   nil,   nil,    29,    31,   nil,    87,    16,    17,
    20,    22,    84,    25,   nil,   nil,    29,    31,   nil,    87,
    16,    17,    20,    22,    84,    25,   nil,   nil,    29,    31,
   nil,    87,    16,    17,    20,    22 ]

racc_action_check = [
    75,    28,    68,    68,   136,   136,    68,    68,    72,    72,
    68,    68,    68,    68,   126,    68,    75,    28,    68,    67,
    75,    28,   143,    66,    86,    86,    75,    28,    75,    75,
    28,     3,     3,    86,   143,     3,     3,   134,   134,     3,
     3,     3,     3,    73,     3,   152,   152,     3,    62,   152,
   152,    60,    56,   152,   152,   152,   152,    51,   152,    52,
    52,   152,    80,    52,    52,    52,    50,    52,    52,    52,
    52,    45,    89,    52,    42,    52,    71,    71,    41,    96,
    71,    71,    97,    98,    71,    71,    71,    71,   100,     7,
     7,   101,    71,     7,     7,   102,   104,     7,     7,     7,
     7,   105,     7,     8,     8,     7,   108,     8,     8,   111,
   112,     8,     8,     8,     8,    40,     8,     9,     9,     8,
    36,     9,     9,   117,   121,     9,     9,     9,     9,    33,
    10,    10,    70,     9,    10,    10,    13,    12,    10,    10,
    10,    10,   130,     2,     2,   131,    10,     2,     2,    11,
   135,     2,     2,     2,     2,     6,     2,   138,   139,     2,
    90,    90,    90,   140,    90,    90,   141,   142,    90,    90,
    90,    90,     5,    90,   148,   151,    90,   127,   127,   127,
     4,   127,   127,     1,   157,   127,   127,   127,   127,   159,
   127,    26,    26,   127,    26,    26,    26,   163,   164,    26,
    26,    26,    26,   nil,    26,    27,    27,    26,   nil,    27,
    27,    27,   nil,    27,    27,    27,    27,   nil,   155,   155,
   nil,    27,   155,   155,   nil,   nil,   155,   155,   155,   155,
   nil,   122,   122,   nil,   155,   122,   122,   nil,   nil,   122,
   122,   122,   122,   nil,    76,    76,   nil,   122,    76,    76,
   nil,   nil,    76,    76,    76,    76,   nil,    38,    38,   nil,
    76,    38,    38,   nil,   nil,    38,    38,    38,    38,   nil,
    38,    55,    55,    38,   nil,    55,    55,   nil,   nil,    55,
    55,    55,    55,   nil,    94,    94,   nil,    55,    94,    94,
   nil,   nil,    94,    94,    94,    94,   nil,    59,    59,   nil,
    94,    59,    59,   nil,   nil,    59,    59,    59,    59,   nil,
   114,   114,   nil,    59,   114,   114,   nil,   114,   114,   114,
   114,   114,     0,     0,     0,     0,     0,     0,     0,     0,
     0,     0,     0,     0,    77,    77,   nil,   nil,    77,    77,
   nil,    77,    77,    77,    77,    77,    44,    44,   nil,   nil,
    44,    44,   nil,    44,    44,    44,    44,    44,   113,   113,
   nil,   nil,   113,   113,   nil,   113,   113,   113,   113,   113,
    88,    88,   nil,   nil,    88,    88,   nil,    88,    88,    88,
    88,    88,    74,    74,   nil,   nil,    74,    74,   nil,    74,
    74,    74,    74,    74,   129,   129,   nil,   nil,   129,   129,
   nil,   129,   129,   129,   129,   129 ]

racc_action_pointer = [
   320,   152,   129,    17,   165,   172,   137,    75,    89,   103,
   116,   135,   106,   105,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   177,   191,     1,   nil,
   nil,   nil,   nil,   109,   nil,   nil,    94,   nil,   243,   nil,
    99,    64,    74,   nil,   332,    52,   nil,   nil,   nil,   nil,
    50,    31,    45,   nil,   nil,   257,    36,   nil,   nil,   283,
    22,   nil,    16,   nil,   nil,   nil,    -3,   -10,   -12,   nil,
   103,    62,    -8,    15,   368,     0,   230,   320,   nil,   nil,
    47,   nil,   nil,   nil,   nil,   nil,     4,   nil,   356,    50,
   146,   nil,   nil,   nil,   270,   nil,    65,    56,    52,   nil,
    57,    62,    79,   nil,    68,    81,   nil,   nil,    77,   nil,
   nil,    80,    96,   344,   296,   nil,   nil,   108,   nil,   nil,
   nil,    98,   217,   nil,   nil,   nil,   -19,   163,   nil,   380,
   128,   116,   nil,   nil,    14,   124,   -26,   nil,   128,   141,
   148,   141,   152,     7,   nil,   nil,   nil,   nil,   160,   nil,
   nil,   149,    31,   nil,   nil,   204,   nil,   167,   nil,   174,
   nil,   nil,   nil,   169,   184,   nil,   nil,   nil ]

racc_action_default = [
  -110,  -110,  -110,  -110,   -14,  -110,   -20,  -110,  -110,  -110,
  -110,  -110,  -110,  -110,   -10,   -95,  -106,  -107,   -77,   -44,
  -108,   -11,  -109,   -79,   -43,  -103,  -110,  -110,   -60,  -104,
   -55,  -105,   -78,   -68,   -54,   -71,   -45,   -12,  -110,    -1,
  -110,  -110,  -110,    -2,  -110,   -22,   -51,   -48,   -50,    -3,
   -40,   -41,  -110,   -46,    -4,   -86,    -5,   -88,    -6,   -90,
  -110,    -7,   -95,    -8,    -9,   -99,  -101,   -61,   -59,   -56,
   -69,  -110,  -110,  -110,  -110,   -75,  -110,  -110,   -57,   -15,
  -110,   168,   -73,   -80,   -82,   -21,   -24,   -81,  -110,   -27,
  -110,   -83,   -47,   -89,  -110,   -91,  -110,  -101,  -110,  -100,
  -102,   -75,   -58,   -52,  -110,  -110,   -64,   -63,   -65,   -76,
   -72,   -67,  -110,  -110,  -110,   -26,   -23,  -110,   -29,   -49,
   -84,   -42,   -87,   -92,   -94,   -95,  -110,  -110,   -62,  -110,
  -110,   -25,   -74,   -28,   -31,  -101,  -110,   -53,   -66,  -110,
  -110,   -34,  -110,  -110,   -93,   -96,   -98,   -97,  -110,   -18,
   -13,   -38,  -110,   -30,   -33,  -110,   -32,   -16,   -19,   -14,
   -35,   -36,   -37,  -110,  -110,   -39,   -85,   -17 ]

racc_goto_table = [
    39,    67,    70,    73,    24,    37,    69,    66,    36,    38,
    57,    59,    55,    67,   108,    83,    90,   111,    69,    99,
    85,    49,    53,    76,   158,   134,   141,    70,    73,   151,
   118,    89,    45,   156,   160,   150,   140,    21,    14,    19,
   119,   102,    64,    63,    61,    83,    70,   104,    83,    58,
   124,   132,    56,   131,    97,    54,    93,    43,     5,    83,
    95,   145,    76,   nil,   116,    76,   nil,   nil,   127,   138,
   103,   nil,   nil,   nil,    38,   nil,   nil,   110,   nil,   nil,
   nil,   nil,   nil,   nil,    83,    83,   nil,   nil,   144,   nil,
   nil,   nil,   nil,   nil,   nil,    57,   121,   122,   nil,   nil,
    83,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   135,   nil,   nil,
   nil,   nil,   nil,    93,   nil,   nil,   nil,    70,   162,   137,
    70,   163,   161,    38,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   165 ]

racc_goto_check = [
     2,    37,    37,    29,    13,    13,    28,    46,    31,    36,
    41,    41,    45,    37,    25,    44,    32,    25,    28,    47,
    24,     4,     4,    42,    23,    20,    21,    37,    29,    22,
    19,    18,    17,    26,    27,    16,    15,    12,    11,    33,
    34,    35,    10,     9,     8,    44,    37,    29,    44,     7,
    47,    43,     6,    25,    46,     5,    41,     3,     1,    44,
    41,    48,    42,   nil,    24,    42,   nil,   nil,    32,    25,
    13,   nil,   nil,   nil,    36,   nil,   nil,    41,   nil,   nil,
   nil,   nil,   nil,   nil,    44,    44,   nil,   nil,    47,   nil,
   nil,   nil,   nil,   nil,   nil,    41,    31,    45,   nil,   nil,
    44,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,    46,   nil,   nil,
   nil,   nil,   nil,    41,   nil,   nil,   nil,    37,    29,    13,
    37,    29,    28,    36,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,     2 ]

racc_goto_pointer = [
   nil,    58,    -4,    51,    14,    47,    43,    39,    33,    31,
    29,    37,    35,     2,   nil,   -94,  -105,    26,   -14,   -59,
   -93,  -108,  -112,  -127,   -24,   -60,  -110,  -118,   -20,   -24,
   nil,     6,   -34,    37,   -50,   -27,     6,   -25,   nil,   nil,
   nil,     1,    -5,   -63,   -29,     3,    -8,   -47,   -75 ]

racc_goto_default = [
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,    48,    41,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,    86,   nil,   nil,    30,    34,
    50,    51,   nil,    46,    47,   nil,    26,    28,    71,    72,
    33,    35,   114,    82,    18,   nil,   nil,   nil,   nil ]

racc_token_table = {
 false => 0,
 Object.new => 1,
 :DATETIME => 2,
 :RECEIVED => 3,
 :MADDRESS => 4,
 :RETPATH => 5,
 :KEYWORDS => 6,
 :ENCRYPTED => 7,
 :MIMEVERSION => 8,
 :CTYPE => 9,
 :CENCODING => 10,
 :CDISPOSITION => 11,
 :ADDRESS => 12,
 :MAILBOX => 13,
 :DIGIT => 14,
 :ATOM => 15,
 "," => 16,
 ":" => 17,
 :FROM => 18,
 :BY => 19,
 "@" => 20,
 :DOMLIT => 21,
 :VIA => 22,
 :WITH => 23,
 :ID => 24,
 :FOR => 25,
 ";" => 26,
 "<" => 27,
 ">" => 28,
 "." => 29,
 :QUOTED => 30,
 :TOKEN => 31,
 "/" => 32,
 "=" => 33 }

racc_use_result_var = false

racc_nt_base = 34

Racc_arg = [
 racc_action_table,
 racc_action_check,
 racc_action_default,
 racc_action_pointer,
 racc_goto_table,
 racc_goto_check,
 racc_goto_default,
 racc_goto_pointer,
 racc_nt_base,
 racc_reduce_table,
 racc_token_table,
 racc_shift_n,
 racc_reduce_n,
 racc_use_result_var ]

Racc_token_to_s_table = [
'$end',
'error',
'DATETIME',
'RECEIVED',
'MADDRESS',
'RETPATH',
'KEYWORDS',
'ENCRYPTED',
'MIMEVERSION',
'CTYPE',
'CENCODING',
'CDISPOSITION',
'ADDRESS',
'MAILBOX',
'DIGIT',
'ATOM',
'","',
'":"',
'FROM',
'BY',
'"@"',
'DOMLIT',
'VIA',
'WITH',
'ID',
'FOR',
'";"',
'"<"',
'">"',
'"."',
'QUOTED',
'TOKEN',
'"/"',
'"="',
'$start',
'content',
'datetime',
'received',
'addrs_TOP',
'retpath',
'keys',
'enc',
'version',
'ctype',
'cencode',
'cdisp',
'addr_TOP',
'mbox',
'day',
'hour',
'zone',
'from',
'by',
'via',
'with',
'id',
'for',
'received_datetime',
'received_domain',
'domain',
'msgid',
'received_addrspec',
'routeaddr',
'spec',
'addrs',
'group_bare',
'commas',
'group',
'addr',
'mboxes',
'addr_phrase',
'local_head',
'routes',
'at_domains',
'local',
'word',
'dots',
'domword',
'atom',
'phrase',
'params',
'opt_semicolon',
'value']

Racc_debug_parser = false

##### racc system variables end #####

 # reduce 0 omitted

module_eval <<'.,.,', 'parser.y', 16
  def _reduce_1( val, _values)
 val[1]
  end
.,.,

module_eval <<'.,.,', 'parser.y', 17
  def _reduce_2( val, _values)
 val[1]
  end
.,.,

module_eval <<'.,.,', 'parser.y', 18
  def _reduce_3( val, _values)
 val[1]
  end
.,.,

module_eval <<'.,.,', 'parser.y', 19
  def _reduce_4( val, _values)
 val[1]
  end
.,.,

module_eval <<'.,.,', 'parser.y', 20
  def _reduce_5( val, _values)
 val[1]
  end
.,.,

module_eval <<'.,.,', 'parser.y', 21
  def _reduce_6( val, _values)
 val[1]
  end
.,.,

module_eval <<'.,.,', 'parser.y', 22
  def _reduce_7( val, _values)
 val[1]
  end
.,.,

module_eval <<'.,.,', 'parser.y', 23
  def _reduce_8( val, _values)
 val[1]
  end
.,.,

module_eval <<'.,.,', 'parser.y', 24
  def _reduce_9( val, _values)
 val[1]
  end
.,.,

module_eval <<'.,.,', 'parser.y', 25
  def _reduce_10( val, _values)
 val[1]
  end
.,.,

module_eval <<'.,.,', 'parser.y', 26
  def _reduce_11( val, _values)
 val[1]
  end
.,.,

module_eval <<'.,.,', 'parser.y', 27
  def _reduce_12( val, _values)
 val[1]
  end
.,.,

module_eval <<'.,.,', 'parser.y', 33
  def _reduce_13( val, _values)
                  t = Time.gm(val[3].to_i, val[2], val[1].to_i, 0, 0, 0)
                  (t + val[4] - val[5]).localtime
  end
.,.,

 # reduce 14 omitted

 # reduce 15 omitted

module_eval <<'.,.,', 'parser.y', 42
  def _reduce_16( val, _values)
                  (val[0].to_i * 60 * 60) +
                  (val[2].to_i * 60)
  end
.,.,

module_eval <<'.,.,', 'parser.y', 47
  def _reduce_17( val, _values)
                  (val[0].to_i * 60 * 60) +
                  (val[2].to_i * 60) +
                  (val[4].to_i)
  end
.,.,

module_eval <<'.,.,', 'parser.y', 54
  def _reduce_18( val, _values)
                  timezone_string_to_unixtime(val[0])
  end
.,.,

module_eval <<'.,.,', 'parser.y', 59
  def _reduce_19( val, _values)
                  val
  end
.,.,

 # reduce 20 omitted

module_eval <<'.,.,', 'parser.y', 65
  def _reduce_21( val, _values)
                  val[1]
  end
.,.,

 # reduce 22 omitted

module_eval <<'.,.,', 'parser.y', 71
  def _reduce_23( val, _values)
                  val[1]
  end
.,.,

module_eval <<'.,.,', 'parser.y', 77
  def _reduce_24( val, _values)
                  join_domain(val[0])
  end
.,.,

module_eval <<'.,.,', 'parser.y', 81
  def _reduce_25( val, _values)
                  join_domain(val[2])
  end
.,.,

module_eval <<'.,.,', 'parser.y', 85
  def _reduce_26( val, _values)
                  join_domain(val[0])
  end
.,.,

 # reduce 27 omitted

module_eval <<'.,.,', 'parser.y', 91
  def _reduce_28( val, _values)
                  val[1]
  end
.,.,

module_eval <<'.,.,', 'parser.y', 96
  def _reduce_29( val, _values)
                  []
  end
.,.,

module_eval <<'.,.,', 'parser.y', 100
  def _reduce_30( val, _values)
                  val[0].push val[2]
                  val[0]
  end
.,.,

 # reduce 31 omitted

module_eval <<'.,.,', 'parser.y', 107
  def _reduce_32( val, _values)
                  val[1]
  end
.,.,

module_eval <<'.,.,', 'parser.y', 111
  def _reduce_33( val, _values)
                  val[1]
  end
.,.,

 # reduce 34 omitted

module_eval <<'.,.,', 'parser.y', 117
  def _reduce_35( val, _values)
                  val[1]
  end
.,.,

module_eval <<'.,.,', 'parser.y', 123
  def _reduce_36( val, _values)
                  val[0].spec
  end
.,.,

module_eval <<'.,.,', 'parser.y', 127
  def _reduce_37( val, _values)
                  val[0].spec
  end
.,.,

 # reduce 38 omitted

module_eval <<'.,.,', 'parser.y', 134
  def _reduce_39( val, _values)
                  val[1]
  end
.,.,

 # reduce 40 omitted

 # reduce 41 omitted

 # reduce 42 omitted

 # reduce 43 omitted

 # reduce 44 omitted

 # reduce 45 omitted

 # reduce 46 omitted

module_eval <<'.,.,', 'parser.y', 146
  def _reduce_47( val, _values)
 [ Address.new(nil, nil) ]
  end
.,.,

module_eval <<'.,.,', 'parser.y', 148
  def _reduce_48( val, _values)
 val
  end
.,.,

module_eval <<'.,.,', 'parser.y', 149
  def _reduce_49( val, _values)
 val[0].push val[2]; val[0]
  end
.,.,

 # reduce 50 omitted

 # reduce 51 omitted

module_eval <<'.,.,', 'parser.y', 156
  def _reduce_52( val, _values)
                  val
  end
.,.,

module_eval <<'.,.,', 'parser.y', 160
  def _reduce_53( val, _values)
                  val[0].push val[2]
                  val[0]
  end
.,.,

 # reduce 54 omitted

 # reduce 55 omitted

module_eval <<'.,.,', 'parser.y', 168
  def _reduce_56( val, _values)
                  val[1].phrase = Decoder.decode(val[0])
                  val[1]
  end
.,.,

 # reduce 57 omitted

module_eval <<'.,.,', 'parser.y', 176
  def _reduce_58( val, _values)
                  AddressGroup.new(val[0], val[2])
  end
.,.,

module_eval <<'.,.,', 'parser.y', 178
  def _reduce_59( val, _values)
 AddressGroup.new(val[0], [])
  end
.,.,

module_eval <<'.,.,', 'parser.y', 181
  def _reduce_60( val, _values)
 val[0].join('.')
  end
.,.,

module_eval <<'.,.,', 'parser.y', 182
  def _reduce_61( val, _values)
 val[0] << ' ' << val[1].join('.')
  end
.,.,

module_eval <<'.,.,', 'parser.y', 186
  def _reduce_62( val, _values)
                  val[2].routes.replace val[1]
                  val[2]
  end
.,.,

module_eval <<'.,.,', 'parser.y', 191
  def _reduce_63( val, _values)
                  val[1]
  end
.,.,

 # reduce 64 omitted

module_eval <<'.,.,', 'parser.y', 196
  def _reduce_65( val, _values)
 [ val[1].join('.') ]
  end
.,.,

module_eval <<'.,.,', 'parser.y', 197
  def _reduce_66( val, _values)
 val[0].push val[3].join('.'); val[0]
  end
.,.,

module_eval <<'.,.,', 'parser.y', 199
  def _reduce_67( val, _values)
 Address.new( val[0], val[2] )
  end
.,.,

module_eval <<'.,.,', 'parser.y', 200
  def _reduce_68( val, _values)
 Address.new( val[0], nil )
  end
.,.,

 # reduce 69 omitted

module_eval <<'.,.,', 'parser.y', 203
  def _reduce_70( val, _values)
 val[0].push ''; val[0]
  end
.,.,

module_eval <<'.,.,', 'parser.y', 206
  def _reduce_71( val, _values)
 val
  end
.,.,

module_eval <<'.,.,', 'parser.y', 209
  def _reduce_72( val, _values)
                  val[1].times do
                    val[0].push ''
                  end
                  val[0].push val[2]
                  val[0]
  end
.,.,

module_eval <<'.,.,', 'parser.y', 217
  def _reduce_73( val, _values)
 val
  end
.,.,

module_eval <<'.,.,', 'parser.y', 220
  def _reduce_74( val, _values)
                  val[1].times do
                    val[0].push ''
                  end
                  val[0].push val[2]
                  val[0]
  end
.,.,

module_eval <<'.,.,', 'parser.y', 227
  def _reduce_75( val, _values)
 0
  end
.,.,

module_eval <<'.,.,', 'parser.y', 228
  def _reduce_76( val, _values)
 1
  end
.,.,

 # reduce 77 omitted

 # reduce 78 omitted

 # reduce 79 omitted

 # reduce 80 omitted

 # reduce 81 omitted

 # reduce 82 omitted

 # reduce 83 omitted

 # reduce 84 omitted

module_eval <<'.,.,', 'parser.y', 243
  def _reduce_85( val, _values)
                  val[1] = val[1].spec
                  val.join('')
  end
.,.,

module_eval <<'.,.,', 'parser.y', 247
  def _reduce_86( val, _values)
 val
  end
.,.,

module_eval <<'.,.,', 'parser.y', 248
  def _reduce_87( val, _values)
 val[0].push val[2]; val[0]
  end
.,.,

 # reduce 88 omitted

module_eval <<'.,.,', 'parser.y', 251
  def _reduce_89( val, _values)
 val[0] << ' ' << val[1]
  end
.,.,

module_eval <<'.,.,', 'parser.y', 255
  def _reduce_90( val, _values)
                  val.push nil
                  val
  end
.,.,

module_eval <<'.,.,', 'parser.y', 260
  def _reduce_91( val, _values)
                  val
  end
.,.,

module_eval <<'.,.,', 'parser.y', 265
  def _reduce_92( val, _values)
                  [ val[0].to_i, val[2].to_i ]
  end
.,.,

module_eval <<'.,.,', 'parser.y', 270
  def _reduce_93( val, _values)
                  [ val[0].downcase, val[2].downcase, decode_params(val[3]) ]
  end
.,.,

module_eval <<'.,.,', 'parser.y', 274
  def _reduce_94( val, _values)
                  [ val[0].downcase, nil, decode_params(val[1]) ]
  end
.,.,

module_eval <<'.,.,', 'parser.y', 279
  def _reduce_95( val, _values)
                  {}
  end
.,.,

module_eval <<'.,.,', 'parser.y', 283
  def _reduce_96( val, _values)
                  val[0][ val[2].downcase ] = val[4]
                  val[0]
  end
.,.,

 # reduce 97 omitted

 # reduce 98 omitted

module_eval <<'.,.,', 'parser.y', 292
  def _reduce_99( val, _values)
                  val[0].downcase
  end
.,.,

module_eval <<'.,.,', 'parser.y', 297
  def _reduce_100( val, _values)
                  [ val[0].downcase, decode_params(val[1]) ]
  end
.,.,

 # reduce 101 omitted

 # reduce 102 omitted

 # reduce 103 omitted

 # reduce 104 omitted

 # reduce 105 omitted

 # reduce 106 omitted

 # reduce 107 omitted

 # reduce 108 omitted

 # reduce 109 omitted

 def _reduce_none( val, _values)
  val[0]
 end

  end   # class Parser

end   # module TMail
