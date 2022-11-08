



/** \brief Java style Doc String - Foo function */
int foo(){return 1;};

int bar(){return 2;}; /**< Bar function */

/// .NET Style Doc String
int g_global_var = 1;

/* Hello
/* World
// */
int baz(){return 3;};
// */

/*! Global variable
 *  ... */
volatile int g_global;

//! Main
int main(int argc, const char* argv)
{
    printf("/* foo bar");
    //*/ printf("1");

    // \
    /*
    printf("2");
    /*/
    printf("3");
    //*/

/\
/*
    printf("4");
/*/
    printf("5");
//*/

    return 1;
}
