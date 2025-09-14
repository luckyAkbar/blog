---
# the default layout is 'page'
icon: fas fa-user-circle
order: 4
---


<div class="cv-header" style="text-align: center; margin-bottom: 2rem; padding: 2rem; background: var(--main-bg); border: 1px solid var(--border-color); border-radius: 10px; box-shadow: var(--shadow-l1);">
  <h1 style="margin: 0; font-size: 2.5rem; font-weight: 300; color: var(--text-color);">{{ site.social.name }}</h1>
  <p style="margin: 0.5rem 0; font-size: 1.2rem; opacity: 0.8; color: var(--text-color);">{{ site.tagline }}</p>
  <div style="margin-top: 1rem; color: var(--text-color);">
    <i class="fas fa-envelope"></i> {{ site.social.email }} &nbsp;&nbsp;
    <i class="fas fa-map-marker-alt"></i> Lampung, Indonesia
  </div>
  <div style="margin-top: 0.5rem;">
    {% if site.social.links %}
      {% for link in site.social.links %}
        {% if link contains 'linkedin.com' %}
          <a href="{{ link }}" style="color: var(--link-color); margin: 0 10px;"><i class="fab fa-linkedin"></i></a>
        {% elsif link contains 'github.com' %}
          <a href="{{ link }}" style="color: var(--link-color); margin: 0 10px;"><i class="fab fa-github"></i></a>
        {% elsif link contains 'twitter.com' %}
          <a href="{{ link }}" style="color: var(--link-color); margin: 0 10px;"><i class="fab fa-twitter"></i></a>
        {% else %}
          <a href="{{ link }}" style="color: var(--link-color); margin: 0 10px;"><i class="fas fa-globe"></i></a>
        {% endif %}
      {% endfor %}
    {% endif %}
  </div>
</div>

## 🎯 Professional Summary

<div class="cv-section" style="background: var(--main-bg); padding: 1.5rem; border-radius: 8px; margin-bottom: 2rem; border-left: 4px solid var(--link-color); border: 1px solid var(--border-color); box-shadow: var(--shadow-l1);">
  <p style="margin: 0; line-height: 1.6; font-size: 1.1rem; color: var(--text-color);">
    [Write a compelling 2-3 sentence summary highlighting your key strengths, years of experience, and what makes you unique in your field. Focus on your most relevant skills and achievements.]
  </p>
</div>

## 💼 Work Experience

<div class="cv-timeline" style="position: relative; padding-left: 2rem; margin-bottom: 2rem;">
  
  <div class="timeline-item" style="position: relative; margin-bottom: 2rem; padding-left: 2rem; border-left: 2px solid var(--border-color);">
    <div class="timeline-marker" style="position: absolute; left: -6px; top: 0; width: 12px; height: 12px; background: var(--link-color); border-radius: 50%;"></div>
    <div class="job-header" style="display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: 0.5rem;">
      <div>
        <h3 style="margin: 0; color: var(--text-color);">[Job Title]</h3>
        <h4 style="margin: 0; color: var(--text-muted); font-weight: normal;">[Company Name]</h4>
      </div>
      <span style="color: var(--text-muted); font-size: 0.9rem;">[Start Date] - [End Date/Present]</span>
    </div>
    <p style="color: var(--text-muted); margin: 0.5rem 0; font-style: italic;">[Location]</p>
    <ul style="margin: 1rem 0; padding-left: 1.5rem; color: var(--text-color);">
      <li>[Key achievement or responsibility]</li>
      <li>[Another significant accomplishment]</li>
      <li>[Quantifiable result or impact]</li>
    </ul>
  </div>

  <div class="timeline-item" style="position: relative; margin-bottom: 2rem; padding-left: 2rem; border-left: 2px solid var(--border-color);">
    <div class="timeline-marker" style="position: absolute; left: -6px; top: 0; width: 12px; height: 12px; background: var(--link-color); border-radius: 50%;"></div>
    <div class="job-header" style="display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: 0.5rem;">
      <div>
        <h3 style="margin: 0; color: var(--text-color);">[Previous Job Title]</h3>
        <h4 style="margin: 0; color: var(--text-muted); font-weight: normal;">[Previous Company]</h4>
      </div>
      <span style="color: var(--text-muted); font-size: 0.9rem;">[Start Date] - [End Date]</span>
    </div>
    <p style="color: var(--text-muted); margin: 0.5rem 0; font-style: italic;">[Location]</p>
    <ul style="margin: 1rem 0; padding-left: 1.5rem; color: var(--text-color);">
      <li>[Key achievement or responsibility]</li>
      <li>[Another significant accomplishment]</li>
      <li>[Quantifiable result or impact]</li>
    </ul>
  </div>

</div>

## 🎓 Education

<div class="cv-section" style="margin-bottom: 2rem;">
  
  <div class="education-item" style="background: var(--main-bg); border: 1px solid var(--border-color); border-radius: 8px; padding: 1.5rem; margin-bottom: 1rem; box-shadow: var(--shadow-l1);">
    <div style="display: flex; justify-content: space-between; align-items: flex-start;">
      <div>
        <h3 style="margin: 0; color: var(--text-color);">[Degree Name]</h3>
        <h4 style="margin: 0.25rem 0; color: var(--text-muted); font-weight: normal;">[University/Institution Name]</h4>
        <p style="margin: 0.25rem 0; color: var(--text-muted); font-style: italic;">[Field of Study]</p>
      </div>
      <span style="color: var(--text-muted); font-size: 0.9rem;">[Graduation Year]</span>
    </div>
    <div style="margin-top: 0.5rem;">
      <span style="background: var(--link-bg); color: var(--link-color); padding: 0.25rem 0.5rem; border-radius: 4px; font-size: 0.8rem; margin-right: 0.5rem;">GPA: [X.XX]</span>
      <span style="background: var(--accent-bg); color: var(--accent-color); padding: 0.25rem 0.5rem; border-radius: 4px; font-size: 0.8rem;">[Honors/Awards]</span>
    </div>
  </div>

</div>

## 🛠️ Technical Skills

<div class="skills-grid" style="display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 1.5rem; margin-bottom: 2rem;">
  
  <div class="skill-category" style="background: var(--main-bg); border: 1px solid var(--border-color); border-radius: 8px; padding: 1.5rem; box-shadow: var(--shadow-l1);">
    <h4 style="margin: 0 0 1rem 0; color: var(--text-color); border-bottom: 2px solid var(--link-color); padding-bottom: 0.5rem;">Programming Languages</h4>
    <div class="skill-tags">
      <span style="background: var(--link-color); color: var(--main-bg); padding: 0.3rem 0.8rem; border-radius: 20px; font-size: 0.85rem; margin: 0.2rem; display: inline-block;">[Language 1]</span>
      <span style="background: var(--accent-color); color: var(--main-bg); padding: 0.3rem 0.8rem; border-radius: 20px; font-size: 0.85rem; margin: 0.2rem; display: inline-block;">[Language 2]</span>
      <span style="background: var(--text-muted); color: var(--main-bg); padding: 0.3rem 0.8rem; border-radius: 20px; font-size: 0.85rem; margin: 0.2rem; display: inline-block;">[Language 3]</span>
    </div>
  </div>

  <div class="skill-category" style="background: var(--main-bg); border: 1px solid var(--border-color); border-radius: 8px; padding: 1.5rem; box-shadow: var(--shadow-l1);">
    <h4 style="margin: 0 0 1rem 0; color: var(--text-color); border-bottom: 2px solid var(--accent-color); padding-bottom: 0.5rem;">Frameworks & Tools</h4>
    <div class="skill-tags">
      <span style="background: var(--link-color); color: var(--main-bg); padding: 0.3rem 0.8rem; border-radius: 20px; font-size: 0.85rem; margin: 0.2rem; display: inline-block;">[Framework 1]</span>
      <span style="background: var(--accent-color); color: var(--main-bg); padding: 0.3rem 0.8rem; border-radius: 20px; font-size: 0.85rem; margin: 0.2rem; display: inline-block;">[Framework 2]</span>
      <span style="background: var(--text-muted); color: var(--main-bg); padding: 0.3rem 0.8rem; border-radius: 20px; font-size: 0.85rem; margin: 0.2rem; display: inline-block;">[Tool 1]</span>
    </div>
  </div>

  <div class="skill-category" style="background: var(--main-bg); border: 1px solid var(--border-color); border-radius: 8px; padding: 1.5rem; box-shadow: var(--shadow-l1);">
    <h4 style="margin: 0 0 1rem 0; color: var(--text-color); border-bottom: 2px solid var(--text-muted); padding-bottom: 0.5rem;">Technologies</h4>
    <div class="skill-tags">
      <span style="background: var(--link-color); color: var(--main-bg); padding: 0.3rem 0.8rem; border-radius: 20px; font-size: 0.85rem; margin: 0.2rem; display: inline-block;">[Technology 1]</span>
      <span style="background: var(--accent-color); color: var(--main-bg); padding: 0.3rem 0.8rem; border-radius: 20px; font-size: 0.85rem; margin: 0.2rem; display: inline-block;">[Technology 2]</span>
      <span style="background: var(--text-muted); color: var(--main-bg); padding: 0.3rem 0.8rem; border-radius: 20px; font-size: 0.85rem; margin: 0.2rem; display: inline-block;">[Technology 3]</span>
    </div>
  </div>

</div>

## 🏆 Certifications & Achievements

<div class="achievements-grid" style="display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 1rem; margin-bottom: 2rem;">
  
  <div class="achievement-item" style="background: var(--link-color); color: var(--main-bg); padding: 1.5rem; border-radius: 8px; text-align: center; box-shadow: var(--shadow-l1);">
    <i class="fas fa-certificate" style="font-size: 2rem; margin-bottom: 1rem;"></i>
    <h4 style="margin: 0 0 0.5rem 0; color: var(--main-bg);">[Certification Name]</h4>
    <p style="margin: 0; font-size: 0.9rem; opacity: 0.9; color: var(--main-bg);">[Issuing Organization]</p>
    <small style="color: var(--main-bg);">[Year]</small>
  </div>

  <div class="achievement-item" style="background: var(--link-color); color: var(--main-bg); padding: 1.5rem; border-radius: 8px; text-align: center; box-shadow: var(--shadow-l1);">
    <i class="fas fa-certificate" style="font-size: 2rem; margin-bottom: 1rem;"></i>
    <h4 style="margin: 0 0 0.5rem 0; color: var(--main-bg);">[Certification Name]</h4>
    <p style="margin: 0; font-size: 0.9rem; opacity: 0.9; color: var(--main-bg);">[Issuing Organization]</p>
    <small style="color: var(--main-bg);">[Year]</small>
  </div>

  <div class="achievement-item" style="background: var(--link-color); color: var(--main-bg); padding: 1.5rem; border-radius: 8px; text-align: center; box-shadow: var(--shadow-l1);">
    <i class="fas fa-certificate" style="font-size: 2rem; margin-bottom: 1rem;"></i>
    <h4 style="margin: 0 0 0.5rem 0; color: var(--main-bg);">[Certification Name]</h4>
    <p style="margin: 0; font-size: 0.9rem; opacity: 0.9; color: var(--main-bg);">[Issuing Organization]</p>
    <small style="color: var(--main-bg);">[Year]</small>
  </div>

</div>

## 📚 Projects

<div class="projects-section" style="margin-bottom: 2rem;">
  
  <div class="project-item" style="background: var(--main-bg); border: 1px solid var(--border-color); border-radius: 8px; padding: 1.5rem; margin-bottom: 1.5rem; box-shadow: var(--shadow-l1);">
    <div style="display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: 1rem;">
      <h3 style="margin: 0; color: var(--text-color);">[Project Name]</h3>
      <div>
        <a href="[GitHub Link]" style="color: var(--link-color); margin-right: 1rem;"><i class="fab fa-github"></i> GitHub</a>
        <a href="[Live Demo]" style="color: var(--accent-color);"><i class="fas fa-external-link-alt"></i> Live Demo</a>
      </div>
    </div>
    <p style="color: var(--text-muted); margin: 0.5rem 0;">[Brief description of the project and its purpose]</p>
    <div style="margin: 1rem 0;">
      <strong style="color: var(--text-color);">Technologies used:</strong>
      <span style="background: var(--border-color); color: var(--text-color); padding: 0.2rem 0.5rem; border-radius: 4px; font-size: 0.8rem; margin: 0.2rem; display: inline-block;">[Tech 1]</span>
      <span style="background: var(--border-color); color: var(--text-color); padding: 0.2rem 0.5rem; border-radius: 4px; font-size: 0.8rem; margin: 0.2rem; display: inline-block;">[Tech 2]</span>
      <span style="background: var(--border-color); color: var(--text-color); padding: 0.2rem 0.5rem; border-radius: 4px; font-size: 0.8rem; margin: 0.2rem; display: inline-block;">[Tech 3]</span>
    </div>
    <ul style="margin: 1rem 0; padding-left: 1.5rem; color: var(--text-color);">
      <li>[Key feature or accomplishment]</li>
      <li>[Another notable aspect]</li>
    </ul>
  </div>

</div>

## 🌍 Languages

<div class="languages-section" style="background: var(--main-bg); border: 1px solid var(--border-color); padding: 1.5rem; border-radius: 8px; margin-bottom: 2rem; box-shadow: var(--shadow-l1);">
  <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 1rem;">
    <div class="language-item" style="text-align: center;">
      <h4 style="margin: 0 0 0.5rem 0; color: var(--text-color);">[Language 1]</h4>
      <div style="background: var(--border-color); border-radius: 10px; height: 8px; margin-bottom: 0.5rem;">
        <div style="background: var(--link-color); height: 100%; border-radius: 10px; width: 90%;"></div>
      </div>
      <small style="color: var(--text-muted);">[Proficiency Level]</small>
    </div>
    <div class="language-item" style="text-align: center;">
      <h4 style="margin: 0 0 0.5rem 0; color: var(--text-color);">[Language 2]</h4>
      <div style="background: var(--border-color); border-radius: 10px; height: 8px; margin-bottom: 0.5rem;">
        <div style="background: var(--accent-color); height: 100%; border-radius: 10px; width: 75%;"></div>
      </div>
      <small style="color: var(--text-muted);">[Proficiency Level]</small>
    </div>
  </div>
</div>

## 📞 Contact Information

<div class="contact-section" style="background: var(--link-color); color: var(--main-bg); padding: 2rem; border-radius: 10px; text-align: center; box-shadow: var(--shadow-l1);">
  <h3 style="margin: 0 0 1.5rem 0; color: var(--main-bg);">Let's Connect!</h3>
  <div style="display: flex; justify-content: center; flex-wrap: wrap; gap: 2rem;">
    <div style="display: flex; align-items: center;">
      <i class="fas fa-envelope" style="margin-right: 0.5rem; color: var(--main-bg);"></i>
      <a href="mailto:{{ site.social.email }}" style="color: var(--main-bg); text-decoration: none;">{{ site.social.email }}</a>
    </div>
    <div style="display: flex; align-items: center;">
      <i class="fas fa-phone" style="margin-right: 0.5rem; color: var(--main-bg);"></i>
      <span style="color: var(--main-bg);">+1 (555) 123-4567</span>
    </div>
    <div style="display: flex; align-items: center;">
      <i class="fas fa-map-marker-alt" style="margin-right: 0.5rem; color: var(--main-bg);"></i>
      <span style="color: var(--main-bg);">[Your City, Country]</span>
    </div>
  </div>
  <div style="margin-top: 1.5rem;">
    <a href="https://minio.luckyakbar.web.id/reactiveresume/cm68sp1a2000014pb2h0o3s9c/resumes/backend-engineer.pdf" style="background: rgba(255,255,255,0.2); color: var(--main-bg); padding: 0.75rem 1.5rem; border-radius: 25px; text-decoration: none; margin: 0 0.5rem; display: inline-block;">
      <i class="fas fa-download"></i> Download Resume
    </a>
  </div>
</div>

---

<div style="text-align: center; margin-top: 2rem; padding: 1rem; color: var(--text-muted); font-size: 0.9rem;">
  <p><em>Last updated: [Current Date]</em></p>
</div>