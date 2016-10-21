
import Ruby

public func main(){
    
    ruby_init();

	var state:Int32 = -5;
	var result = rb_eval_string_protect("puts 'Hello, world!'", &state);
//	ruby_init()
//	ruby_init_loadpath()

//    ruby_script("puts 'OHAI!'")
}

struct Apollo {

    var text = "Hello, World!"
}
