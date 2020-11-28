export interface Taco {
  base_layer:{
      url: string;
      slug: string;
      name: string;
      recipe: string;
  };
  shell : {
      url: string;
      slug: string;
      name: string;
      recipe: string;
  };
  seasoning : {
      url: string;
      slug: string;
      name: string;
      recipe: string;
  };
  mixin : {
      url: string;
      slug: string;
      name: string;
      recipe: string;
  };
  condiment : {
      url: string;
      slug: string;
      name: string;
      recipe: string;
  }
}