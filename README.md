Thesaurused
===========
A code poetry machine

### What is it
Thesaurused takes a text file and replaces many words into synonyms.  
Intended to use existing poems as input.

### Usage
YOU MUST REGISTER TO BIG HUGE THESAURUS AND GET API KEY, REPLACING KEY INSIDE THE CODE
```
# Set Dinosaurus
Dinosaurus.configure do |config|
	config.api_key = 'YOUR_KEY_HERE'
end
```
Basic usage is:

	$ ./thesaurused.rb the_road_not_taken_by_robert_frost.txt

You can add `say` or `showoriginal` options.

	$ ./thesaurused.rb say showoriginal the_road_not_taken_by_robert_frost.txt

### Dependencies
```
require "rubygems"
require "stanford-core-nlp"
require "dinosaurus"
require "linguistics"
```

### Legal
[Stanford-core-nlp](https://github.com/louismullie/stanford-core-nlp) uses [Stanford CoreNLP](http://nlp.stanford.edu/software/corenlp.shtml) which is licensed under the GNU General Public License (v2 or later)

[Dinosaurus](https://github.com/dtuite/dinosaurus) uses Big Huge Thesaurus API provided by [words.bighugelabs.com](words.bighugelabs.com)

[Linguistics](https://github.com/ged/linguistics) is licensed as below:

>Copyright © 2003-2012, Michael Granger All rights reserved.
>
>THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS “AS IS” AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.