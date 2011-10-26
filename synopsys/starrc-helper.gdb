# StarRC helper

set print demangle on
set demangle-style auto
#set print pretty on
#set print array on


# Print Psi_String
define printString
    print $arg0.data_address()
end
document printString
  Prints the contents of a Psi_String
end

define printWrap
    set $data_type = print $arg0.__data
end


# -----------------------------------
# HN
# -----------------------------------

define hn_is_global_signal
    set $port = $arg0->global
    if ( $port != 1 )
       printf "yes\n"
    else
       printf "no\n"
    end
end

define hn_is_port_signal
    set $port = $arg0->port
    if ( $port != 1 )
       printf "yes\n"
    else
       printf "no\n"
    end
end

define hn_print_token
    printf "[token.i, token.s]=[%d, \"%s\"]\n", $arg0->i, (char*)$arg0->s
end

define hn_print_my_name
    set $name = $arg0->name
    printf "(token.i, token.s)=(%d, \"%s\")\n", $name->i, (char*)$name->s
end

define hn_print_sig
    printf "Signal '%s':\n", (char*)$arg0->name.s
    print *$arg0
end

define hn_display_my_name
    set $name = $arg0->name
    display $name->i
    display (char*)$name->s
end

define hn_print_ins_sigl
    set $sigl = $arg0->sigl
    while $sigl
      set $sig = $sigl->sig
      set $port = $sigl->port
      printf "(\"%s\", \"%s\")->", (char*)$sig->name.s, (char*)$port->s
      set $sigl = $sigl->next
    end

    printf "NULL\n"
end

define hn_print_ins_port
    set $ins = $arg0
    set $def = $ins->def
    set $nports = $def->Nports
    set $ports = $def->port
    set $i = 0

    printf "Instance %s has %d ports as follows,\n", (char*)ins->name.s, $nports

    while $i < $nports
       printf "port[%d] = ", $i
       set $port = $ports[$i++]
       printf "%s\n", (char*)$port->name.s
    end
end

define hn_print_def_ins
    set $def = $arg0
    set $instances = $def->InsArray
    set $nInstances = $def->Nins_this

    set $i = 0

    printf "Cell %s has %d instances as follows,\n", (char*)def->name.s, $nInstances

    while $i < $nInstances
       printf "instance[%d] = ", $i
       set $ins = $instances[$i++]
       printf "%s\n", (char*)$ins->name.s
    end
end

