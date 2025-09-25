#import "utils.typ"

#let make_grid(..args) = {
  grid(
    columns: (1fr, 1.3fr),
    column-gutter: 1em,
    ..args
  )
}


#let load() = [
  #show heading: it => {
    text(
      font: "JetBrainsMono NF",
      fill: utils.colors.navy-blue,
    )[#it]
  }

  #show strong: it => {
    text(fill: luma(10))[#it]
  }

  #set text(size: 12pt)

  #set page(
    margin: (left: 0.65cm, right: 0.32cm, top: 1.65cm, bottom: 0.32cm),
    background: context {
      // https://typst.app/docs/reference/layout/page/#parameters-margin
      let default = calc.min(page.width, page.height) * 2.5 / 21

      block(
        inset: if page.margin == auto { default } else { page.margin },
        make_grid(
          [
            #place(
              rect(
                fill: utils.colors.navy-blue,
                width: 100% - 1em,
                height: 20%,
              ),
              dy: 2pt,
            )

            #align(right, rect(
              fill: utils.colors.golden-yellow,
              height: 100%,
              width: 100% - 2em,
            ))
          ],
          [],
        ),
      )
    },
  )


  #let info = utils.get_persona()
  #make_grid(
    block(
      width: 100%,
      inset: (left: 2em, top: 2em, bottom: 2em),
    )[
      #align(
        center,
        block(
          stroke: 2pt + utils.colors.navy-blue,
          clip: true,
          width: 4cm,
          height: 5cm,
        )[#image(fit: "cover", width: 100%, "../images/" + info.picture)],
      )

      #block(inset: (left: 1em))[
        = Contacto
        #utils.get_contacts()

        = Habilidades
        #utils.get_skills()

        = Idiomas
        #utils.get_languages()

        == Intereses
        #utils.get_hobbies()
      ]
    ],
    [
      #v(1em)
      #block(
        fill: utils.colors.navy-blue,
        width: 100%,
        inset: 1em,
        text(
          fill: white,
          size: 24pt,
          weight: "bold",
        )[
          #v(2em)
          #upper[
            #(if "firstname" in info [ #info.firstname ]) #(
              if "lastname" in info [ #info.lastname ]
            )

          ]

          #text(
            size: 16pt,
            [
              #upper([
                #if "company" in info [#info.company]
              ])
              #if "title" in info [ _#(info.title)_]
            ],
          )
        ],
      )

      = Educación
      #utils.get_education()


      = Proyectos
      #utils.get_projects()

      = Certificados
      #utils.get_certificates()
    ],
  )


]
