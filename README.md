# TurboRouter

TurboRouter is a simple Rails plugin that smooths over some of the complexity and inconsistencies of using turbo-frames. For example, it can be a bit frustrating to understand and predict how turbo enabled links will behave, given the several attribute they can have that can change their behavior, as well as the fact that their location in the context of the DOM can also change how they function. TurboRouter provides a handful of straightforward view helpers that wrap the standard Rails `link_to` helper and set the proper attributes so that each helper generates a link with consistant and predictable behavior, regardless of where it is in the DOM.

Another aspect of turbo_frames that TurboRouter remedies is the fact that you need to wrap the html partials your Rails controllers render back in turbo_frames matching what is in the DOM. Doing this may limit the reusability and flexibility of your templates, and is extra boiler plate code that can easily be abstracted away. TurboRouter does this by rendering your templates with a layout with a dynamic id set to the targeted turbo-frame of the request, so the partials always render with the right turbo_frame wrapper.


This gem is a simple Rails plugin that provides a straight forward pattern and implementation for using turbo_frame navigation in your rails app to provide a seemless SPA (Single Page Application) like experience. With TurboRouter, you can easily take advantage of the latest and greatest that Rails 7 has to offer with almost no overhead.

TurboRouter works by putting a designated turbo_frame in your application layout which will be the target of all navigations where you want to change the main contents of the page. Then, TurboRouter dynamically wraps your view templates with the proper layouts for these navigations, whether they are internal turbo_frame navigations or coming from outside your app, so they are rendered appropriately every time.

For example, if a user clicks a turbo_frame enabled link inside your app that will take them to the show view at `/posts/1`, TurboRouter will render the `show` template with a layout that wraps the template in a turbo_frame that will replace the main contents of your page. But if a user navigates to `https://yourdomain.com/posts/1` from outside your app, TurboRouter will wrap that same `show` template in the full application layout so that your entire webpage is rendered. With TurboRouter, you don't have to worry about manually assigning different layouts based on the request format, and you don't have to write different templates for different request formats either. TurboRouter comes with its own templates out of the box so you can focus on your applicaiton logic and not have to worry about rendering. Oh, and all of the above functionality is evoked in a single line of code, like this:

```ruby
  def show
    @post = Post.find(params[:id])
    turbo_router
  end
```

TurboRouter also solves the problem of ensuring turbo_frame navigations advance your browser history when you want it to (so that back button functionality is preserved) and not when you don't want it to. For example, it's typically not ideal to hit the back button and end up at a form you previously submitted, etc, so rendering the form without advancing the browser history is usually a good idea. TurboRouter provides multiple versions of the method seen above so that you can render your page contents with or without a browser history advance as appropriate. With these features, your Rails app can be a world class SPA and still feel natural to use with browser controls.

TurboRouter also makes sure that navigations from external origins to destinations that should only be reached from inside the app are redirected. For example, if a user navigated to `https://yourdomain.com/posts/new` or `https://yourdomain.com/posts/1/edit` from an external origin you would typically want to redirect them to `https://yourdomain.com/posts` and `https://yourdomain.com/posts/1` respectively, and TurboRouter makes that easy using the following this convention: for url destinations that advance the browser history, navigations from external origins are rendered normally, and for destinations that do not advance the browser history, navigations from external origins are redirected to the root path or a location you provide in the controller or in the action.

Last but not least, TurboFrame is completely opt-in at the action level, meaning you are never going to feel stuck doing it the TurboRouter way when it doesn't quite fit your needs.

In summary, TurboRouter provides the following benefits:

* Saves you from writing boiler plate `respond_to` logic in your controllers when replacing the main page contents.
* Saves you from writing multiple partials/templates for the same action for different request formats.
* Provides a sensible convention for browser history and ensures navigation advances browser history appropriately.
* Instantly makes your controller actions handle both internal turbo_frame requests and external, normal requests beautifully.
* Gives you all of the above without reducing your flexibility or ability to do things differently.

## Installation
Add this line to your application's Gemfile:

```ruby
gem "turbo_router"
```

And then execute:
```bash
$ bundle
```

Then run:
```bash
rails generate turbo_router
```

The above command will create the following files in your app:

* app/helpers/turbo_router_helper.rb
* app/views/layouts/_turbo_router_content.erb
* app/views/layouts/turbo_router_content.erb
* app/views/layouts/turbo_router_stream.erb

The above command will also wrap the `yield` call in `application.html.erb` with the `layouts/turbo_router_content` partial layout like so:

```ruby
  <%= render "layouts/turbo_router_content" do %><%= yield %><% end %>
```

The above layout ultimately wraps its contents with a turbo frame with `id="turbo_router_content"` which will serve as the target for all TurboRouter navigations and the container for your main content.

## Usage
Simply add this line to your `ApplicationController`:

```ruby
class PostsController < ApplicationController
  include TurboRouter::Controller
```

Then call `turbo_router` in your controller actions for visits that should advance the browser's history, like so:

```ruby
  def index
    @posts = Post.all
    turbo_router
  end
```

The above action will look for the default template, `show.erb`. But you can pass in a template instead like so:

```ruby
  def index
    @posts = Post.all
    turbo_router "alternative_post_index"
  end
```

You can also pass in options that will be passed to the underlying render call, like so:

```ruby
  def index
    @posts = Post.all
    turbo_router "alternative_post_index", { locals: { show_archived: false } }
  end
```

For navigation that shouldn't advance browser history, use `turbo_render` instead:

```ruby
  def edit
    @post = Post.find(params[:id])
    turbo_render
  end
```

TODO: Add examples of setting the redirect_path.
TODO: Add examples of setting the redirect_path on the controller
TODO: Add examples of setting the page_layout
TODO: Explain what TurboRouter does with request variants

For form submissions, you can generate a turbo_stream that targets the main turbo_frame (`id="turbo_router_content"`) using the `turbo_router_stream` method:

```ruby
  def create
    @post = Post.new(params)
    respond_to do |format|
      format.turbo_stream do
        if @post.save
          turbo_router_stream "posts/index", show_archived: false
        else
          ...
        end
      end
    end
  end
```

### The next section is more of a work in progress and it's unclear what role the helpers are playing, since the controller logic drives browser history as well and targets the main turbo_frame.

TurboRouter also provides a few view helpers in `turbo_router_helper.rb` to help in generating the main turbo_frame and links that target it. They are `turbo_router_route_to` and `turbo_router_link_to`, which have the exact same API as the Rails helper `link_to` which they wrap, and `turbo_router_frame_tag` which has almost the exact same API as the turbo-rails helper `turbo_frame_tag` which is wraps.

`turbo_router_route_to` advances the browser's history while `turbo_router_link_to` does not. `turbo_router_frame_tag` does not take an id, but rather calls `turbo_frame_tag` with an id of "turbo_router_content" and passes through all other parameters.


## Contributing
### This plugin is currently in it's alpha stage and contributors are welcome!

Things that need to be done:

* Add tests to make sure non turbo_router requests still work (I think it is overriding the layout for all requests, which is wrong).
* Figure out if the link helpers add any value.
* Add dynamic error handling features for turbo_frame.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
