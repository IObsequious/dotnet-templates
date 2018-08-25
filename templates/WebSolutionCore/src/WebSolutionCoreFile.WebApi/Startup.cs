using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using NSwag.AspNetCore;
using Swashbuckle.AspNetCore.Swagger;

namespace WebSolutionCoreFile.WebApi
{
    public class Startup
    {
        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        public IConfiguration Configuration { get; }

        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {
            services.AddMvc().SetCompatibilityVersion(CompatibilityVersion.Version_2_1);

            services.AddSwaggerGen(c =>
            {
                c.SwaggerDoc("v1", new Info
                {
                    Title = "WebSolutionFileCore API",
                    Version = "v1",
                    Description = "WebSolutionFileCore API",
                    Contact = new Contact
                    {
                        Name = "Brad R. Marshall",
                        Email = "bmarshall@sped.mobi",
                        Url = "https://plus.google.com/u/0/109192664764567257859",
                    },
                    License = new License
                    {
                        Name = "MIT License",
                    },


                }
                );

                var xmlFile = $"{Assembly.GetExecutingAssembly().GetName().Name}.xml";
                var xmlPath = Path.Combine(AppContext.BaseDirectory, xmlFile);
                c.IncludeXmlComments(xmlPath);
            });
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IHostingEnvironment env)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }

            app.UseStaticFiles();

            app.UseSwagger();

            app.UseSwaggerUiWithApiExplorer(c =>
            {
                c.GeneratorSettings.SchemaType = NJsonSchema.SchemaType.OpenApi3;
                c.GeneratorSettings.SerializerSettings = new Newtonsoft.Json.JsonSerializerSettings();
                c.GeneratorSettings.SerializerSettings.Formatting = Newtonsoft.Json.Formatting.Indented;
                c.GeneratorSettings.SerializerSettings.NullValueHandling = Newtonsoft.Json.NullValueHandling.Include;
                c.GeneratorSettings.SerializerSettings.MissingMemberHandling = Newtonsoft.Json.MissingMemberHandling.Ignore;

                c.UseJsonEditor = true;
                c.ValidateSpecification = true;

            });

            app.UseMvc();
        }
    }
}
