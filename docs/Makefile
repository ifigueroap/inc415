# 'Makefile'
MARKDOWN = pandoc --from markdown+footnotes --to html --standalone \
	--template template.html \
	--css template.css \
	--self-contained --toc --toc-depth 2 \
	-V mainlink:index.html
all: $(patsubst %.md,%.html,$(wildcard *.md)) Makefile

clean:
	rm -f $(patsubst %.md,%.html,$(wildcard *.md))
	rm -f *.bak *~

%.html: %.md
	$(MARKDOWN) $< --output $@
