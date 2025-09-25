// Colors
#let colors = (
  deep-purple: cmyk(85%, 100%, 17%, 5%),
  teal-green: cmyk(76%, 9%, 46%, 0%),
  golden-yellow: cmyk(5%, 27%, 90%, 0%),
  bright-orange: cmyk(1%, 48%, 89%, 0%),
  red-orange: cmyk(0%, 81%, 74%, 0%),
  navy-blue: cmyk(100%, 93%, 39%, 54%),
)

#let file = yaml("../data/data.yml")

#let layout_colors = (
  text: black,
  contact_icons: colors.navy-blue,
)

#let get_hobbies(data: file) = {
  if not "hobbies" in data { return }

  list(..data.hobbies)
}

#let get_persona(
  data: file,
) = {
  if not "persona" in data { return }

  data.persona
}

#let get_certificates(
  data: file,
) = {
  if not "certificates" in data { return }

  for key in data.certificates.keys() {
    let item = data.certificates.at(key)
    [
      - *#key* #if "company" in item [\- #item.company] #if "date" in item [\- #item.date.] else [.]
    ]
  }
}

#let get_education(
  data: file,
) = {
  if not "education" in data { return }

  for key in data.education.keys() {
    let item = data.education.at(key)
    [
      == #key

      #if "title" in item {
        [_#(item.title)_]
      } else {}

      #if "from" in item and "to" in item {
        text(size: 11pt)[#(item.from) - #(item.to)]
      }
    ]
  }
}

#let get_projects(
  data: file,
) = {
  if not "projects" in data { return }

  for key in data.projects.keys() [
    - *#key* #[
        #let item = data.projects.at(key)
        #if "date" in item [*(*#item.date*)*]
        #if "description" in item [*:* #item.description]
      ]
  ]
}

#let get_languages(
  data: file,
) = {
  if not "languages" in data { return }

  list(..data.languages)
}


#let get_skills(
  data: file,
) = {
  let skills = if "skills" in data {
    data.skills
  } else { return }

  [
    #list(..skills)
  ]
}

#let get_contacts(
  data: file,
) = {
  if not "contacts" in data { return }

  [
    #grid(
      columns: 2,
      column-gutter: 1em,
      row-gutter: 1em,
      ..data
        .contacts
        .keys()
        .map(key => {
          let item = data.contacts.at(key)
          (
            [#key],
            [
              #if "text" in item and "link" in item [
                #link(item.link)[#item.text]
              ] else if "text" in item [
                #item.text
              ] else [
                #item.link
              ]
            ],
          )
        })
        .flatten()
    )
  ]
}
