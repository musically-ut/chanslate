## Dependencies

To install all the necessary dependencies:

    meteor add http coffeescript less

    # Semantic UI
    mrt add semantic-ui

    # Make Semantic UI assets public
    cp -r packages/semantic-ui/lib/semantic-ui/build/uncompressed/fonts public/
    cp -r packages/semantic-ui/lib/semantic-ui/build/uncompressed/images/ public/

    # Remove the unnecessary packages
    meteor remove insecure
    meteor remove autopublish
    
