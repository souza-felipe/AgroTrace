import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';

class TermsContent extends StatelessWidget {
  const TermsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(
              '1. Aceitação dos Termos',
              'Ao utilizar o aplicativo AgroTrace, o usuário declara estar ciente e de acordo com os presentes Termos de Uso e Política de Privacidade. Caso não concorde, o usuário não deverá acessar ou utilizar o sistema.',
            ),
            _buildSection(
              '2. Sobre o AgroTrace',
              'O AgroTrace é um sistema de gestão pecuária inteligente que integra tecnologias de Internet das Coisas (IoT), Inteligência Artificial (IA) e Blockchain para oferecer rastreabilidade e eficiência operacional ao setor agropecuário.\n\nO objetivo do aplicativo é fornecer ferramentas digitais para produtores rurais, técnicos, frigoríficos e demais stakeholders do setor, em conformidade com a legislação brasileira e normas internacionais de rastreabilidade.',
            ),
            _buildSection(
              '3. Cadastro e Responsabilidades do Usuário',
              '• O usuário deve fornecer informações corretas, completas e atualizadas no momento do cadastro.\n\n• O usuário é responsável por manter a confidencialidade de suas credenciais (login, senha, autenticação multifator).\n\n• Qualquer atividade realizada em sua conta será de sua inteira responsabilidade.\n\n• O uso do AgroTrace deve respeitar a legislação vigente, especialmente normas sanitárias, ambientais e de rastreabilidade.\n\nÉ proibido:\n• Utilizar o sistema para fins ilícitos ou fraudulentos.\n• Compartilhar acessos sem autorização.\n• Tentar modificar, invadir ou comprometer a segurança da plataforma.',
            ),
            _buildSection(
              '4. Coleta e Uso de Dados',
              'Em conformidade com a Lei Geral de Proteção de Dados (LGPD – Lei 13.709/2018), o AgroTrace coleta e trata dados pessoais e operacionais para viabilizar sua funcionalidade.\n\nEntre os dados coletados estão:\n• Dados de identificação do usuário (nome, e-mail, telefone, CPF/CNPJ).\n• Dados operacionais (cadastro de animais, movimentações, registros sanitários).\n• Dados de localização (quando aplicável).\n• Logs de uso do sistema para fins de auditoria e segurança.\n\nOs dados são utilizados exclusivamente para:\n• Prestação dos serviços contratados.\n• Cumprimento de obrigações legais e regulatórias (MAPA, SISBOV, órgãos de defesa sanitária).\n• Melhorias na experiência do usuário e desenvolvimento de novas funcionalidades.\n• Garantia de segurança, auditoria e prevenção a fraudes.',
            ),
            _buildSection(
              '5. Compartilhamento de Dados',
              'O AgroTrace poderá compartilhar dados com:\n• Autoridades regulatórias e órgãos governamentais, conforme exigido por lei.\n• Parceiros estratégicos (frigoríficos, seguradoras, laboratórios), mediante consentimento do usuário.\n• Serviços de infraestrutura tecnológica (cloud, IoT, provedores de segurança), sempre com contratos de confidencialidade.\n\nEm nenhuma hipótese os dados serão vendidos a terceiros.',
            ),
            _buildSection(
              '6. Segurança da Informação',
              'O AgroTrace adota criptografia avançada (AES-256, TLS 1.3) para proteger dados em trânsito e em repouso.\n\nTodas as ações dos usuários são registradas em logs de auditoria mantidos por no mínimo 12 meses.\n\nImplementa-se autenticação multifator, bloqueio após tentativas falhas e políticas de senha forte.\n\nApesar dos esforços, nenhum sistema é 100% imune, e o usuário reconhece os riscos inerentes ao uso da internet.',
            ),
            _buildSection(
              '7. Direitos do Usuário (LGPD)',
              'Nos termos da LGPD, o usuário tem direito a:\n• Confirmar se seus dados estão sendo tratados.\n• Solicitar correção ou atualização de informações.\n• Requerer exclusão de dados, quando aplicável.\n• Solicitar portabilidade para outro sistema.\n• Revogar o consentimento de uso a qualquer momento.\n\nEsses pedidos podem ser feitos pelo canal oficial de suporte do AgroTrace.',
            ),
            _buildSection(
              '8. Propriedade Intelectual',
              'O aplicativo, sua marca, logotipo, código-fonte e demais elementos visuais ou funcionais são de propriedade exclusiva do AgroTrace.\n\nÉ proibido copiar, reproduzir ou explorar qualquer parte do sistema sem autorização expressa.',
            ),
            _buildSection(
              '9. Limitação de Responsabilidade',
              'O AgroTrace não se responsabiliza por decisões tomadas pelo usuário com base em relatórios ou indicadores fornecidos pela plataforma.\n\nO sistema é uma ferramenta de apoio e não substitui a responsabilidade do produtor ou de profissionais técnicos.\n\nEm caso de indisponibilidade temporária do sistema, o AgroTrace se compromete a restabelecer os serviços no menor prazo possível, conforme SLA estabelecido.',
            ),
            _buildSection(
              '10. Alterações dos Termos',
              'O AgroTrace poderá atualizar estes Termos de Uso e Política de Privacidade a qualquer momento, sendo responsabilidade do usuário consultá-los periodicamente.\n\nO uso contínuo da plataforma após alterações implica aceitação das novas condições.',
            ),
            _buildSection(
              '11. Foro e Legislação Aplicável',
              'Estes Termos são regidos pela legislação brasileira.\n\nQualquer controvérsia será submetida ao foro da comarca do usuário ou, na ausência de escolha, ao foro da cidade de São Paulo/SP.',
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 14,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
