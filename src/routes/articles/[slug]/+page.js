export async function load({ params }) {
  const article = await import(`../${params.slug}.svx`)
  console.log(article)
  return {
    article
  }
}