#let conf(
  title: none,
  authors: (), doc,
) = {
	set page(
		paper: "a4",
		margin: 0.5in,
		// header: align(
		//  right + horizon,
		//  title
		// ),
	)
	set heading(numbering: "1.")
	set text(font: "New Computer Modern")
	show raw: set text(font: "New Computer Modern Mono")
	set par(justify: true)

	set align(center)
	text(17pt, title)

	let count = authors.len()
	let ncols = calc.min(count, 3)
	grid( columns: (1fr,) * ncols,
		row-gutter: 24pt,
		..authors.map(author => [
			#author.name \
			#author.affiliation
		]),
	)

	v(1em)

	set align(left)
	columns(1, doc)
}

#let rewreq(..lines) = { 
	let reasoning_expr(cont) = {
		if cont == "" [
			$ \ $
		] else [
			$ && quad (#cont) \ $
		]
	}
$

	#if lines.pos().len() != 0 [$
		#lines.pos().at(0)
	$] 
	#if calc.rem(lines.pos().len(), 2) == 0 [$
		&= 
		#reasoning_expr(lines.pos().at(1))
	$]

	#for i in range(
		2-calc.rem(lines.pos().len(), 2), 
		lines.pos().len()-1, 
		step: 2
	) {
		$ 
			&= 
			#lines.pos().at(i) 
			#reasoning_expr(lines.pos().at(i+1))
		$
	} 
$ 

}

#let mono_font = "DejaVu Sans Mono"

#let source_code(
	src,
	lang: none,
	detab: true,
) = {
	let raw_text = read(src)

	if lang == none {
		lang = src.split(".").last()
	}

	if detab {
		raw_text = raw_text.replace("\t", "    ")
	}

	let element = {
		text(
			raw(
				raw_text,
				lang: lang,
			)
		)
	}

	let element = {
		text(
			raw(
				raw_text,
				lang: lang,
			)
		)
	}

	block(
		fill: luma(240),
		inset: 8pt,
		radius: 5pt,
    breakable: false,
		element
	)
}

#let Jac(fs) = { $ upright(bold(J))(fs) $ }
#let Hess(fs) = { $ upright(bold(H))(fs) $ }

#let keyword(kwrd) = { $upright(bold(#kwrd))$ }

#let NOTE(txt, col: red) = block(text(col, "[NOTE: " + txt + "]"))
#let TODO = block(text(red, "TODO"))
