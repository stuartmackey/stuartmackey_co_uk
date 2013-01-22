---
layout: post
title: Detecting a prominent colour
date: 2012-02-28 12:00
categories: [ruby]
author: Stuart
sharing: true
footer: true
---

<p>We are working on a new iOS app at the moment and I was asked by the designer this morning if it would be possible for us to detect the most prominent colour in a user uploaded photo.  I considered using iOS to do the processing and then I reconsidered and looked into how it would be done with ruby.  It turned out that some wonderful developer had already done it and released a gem.  It is amazing how often this happens in the ruby world.</p>

<p>Based on a few rough tests the values it gives out are fairly accurate. Just make sure that you have already installed ImageMagick (which I did with HomeBrew, brew install imagemagick) and set the path to it correctly with </p>

<p><code>Miro.options[:image_magick_path] = YOUR_SERVER_PATH</code></p>



<p>The gem can be found on <a href="https://github.com/jonbuda/miro#readme" title="GitHub">GitHub</a></p>
